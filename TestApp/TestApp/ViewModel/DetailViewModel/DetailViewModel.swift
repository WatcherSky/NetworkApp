//
//  DetailViewModel.swift
//  TestApp
//
//  Created by Владимир on 10.11.2022.
//

import Foundation
import UIKit

class DetailViewModel {
    var product: ProductDetail?
    private var networkManager = NetworkLayer()
}

extension DetailViewModel {
    func fetchProduct(id: Int, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        networkManager.fetchProductId(id: id, completion: { [weak self] results in
            switch results {
            case .success(let productData):
                self?.product = productData
                success()
            case .failure(let error):
                failure(error)
            }
        }
        )}
}
