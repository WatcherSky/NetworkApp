//
//  ProductAPI.swift
//  TestApp
//
//  Created by Владимир on 11.11.2022.
//

import Foundation
import Moya

enum ProductAPI {
    case product
    case productId(Int)
}

extension ProductAPI: TargetType {
    var baseURL: URL {
        return Constants.Network.baseURL
    }
    var path: String {
        switch self {
        case .product:
            return "/products"
        case .productId(let id):
            return "/products/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self{
        case .product:
            return .requestPlain
        case .productId:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String: String]? {
        return [:]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .productId(let id):
            return ["id": id]
        case .product:
            return [:]
        }
    }
}
