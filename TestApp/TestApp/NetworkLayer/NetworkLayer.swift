//
//  NetworkLayer.swift
//  TestApp
//
//  Created by Владимир on 09.11.2022.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<ProductAPI> { get }
    
    func fetchProduct(completion: @escaping (Result<ProductsData, Error>) -> ())
    func fetchProductId(id: Int, completion: @escaping (Result<ProductDetail, Error>) -> ())
}

class NetworkLayer: Networkable {
    var provider = MoyaProvider<ProductAPI>(plugins: [NetworkLoggerPlugin()])
    func fetchProduct(completion: @escaping (Result<ProductsData, Error>) -> ()) {
        request(target: .product, completion: completion)
    }
    func fetchProductId(id: Int, completion: @escaping (Result<ProductDetail, Error>) -> ()) {
        request(target: .productId(id), completion: completion)
    }
}

private extension NetworkLayer {
    private func request<T: Decodable>(target: ProductAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
