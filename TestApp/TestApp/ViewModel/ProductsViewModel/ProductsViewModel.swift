//
//  ProductsViewModel.swift
//  TestApp
//
//  Created by Владимир on 09.11.2022.
//

import Foundation

class ProductsViewModel {
    var products: [Product] = []
    var networkManager = NetworkLayer()
}

extension ProductsViewModel {
    func fetchProducts(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        networkManager.fetchProduct(completion: { [weak self] results in
            switch results {
            case .success(let productData):
                self?.products = productData.products
                success()
            case .failure(let error):
                failure(error)
            }
        }
        )}
}
