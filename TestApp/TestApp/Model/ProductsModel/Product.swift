//
//  Product.swift
//  TestApp
//
//  Created by Владимир on 09.11.2022.
//

import Foundation

struct Product: Codable {
    var id: Int
    var title: String
    var category: String
    var thumbnail: URL?
}

struct ProductsData: Codable {
    let products: [Product]
}
