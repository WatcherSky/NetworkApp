//
//  DetailModel.swift
//  TestApp
//
//  Created by Владимир on 10.11.2022.
//

import Foundation

struct ProductDetail: Codable {
    var id: Int
    var title: String?
    var description: String?
    var price: Int
    var discountPersentage: Double?
    var rating: Double?
    var stock: Int?
    var brand: String?
    var category: String?
    var thumbnail: URL?
    var images: [URL]
}
