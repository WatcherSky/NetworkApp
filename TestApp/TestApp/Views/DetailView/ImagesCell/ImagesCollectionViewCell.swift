//
//  ImagesCollectionViewCell.swift
//  TestApp
//
//  Created by Владимир on 10.11.2022.
//

import UIKit
import Kingfisher

class ImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupImages(url: URL?) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
    
    
}
