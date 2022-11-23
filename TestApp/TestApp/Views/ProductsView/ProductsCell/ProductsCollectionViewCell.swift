//
//  ProductsCollectionViewCell.swift
//  TestApp
//
//  Created by Владимир on 11.11.2022.
//

import UIKit
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewListCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setView(url: URL?, titleText: String, categoryText: String) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        titleLabel.text = titleText
        categoryLabel.text = "Category: \(categoryText)"
    }
}
