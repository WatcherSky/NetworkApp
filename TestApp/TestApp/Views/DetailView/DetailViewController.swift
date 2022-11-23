//
//  DetailViewController.swift
//  TestApp
//
//  Created by Владимир on 09.11.2022.
//

import UIKit

class DetailViewController: UIViewController, Transition {
    @IBOutlet private weak var pageControll: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var brandLabel: UILabel!
    
    var id: Int?
    
    private var viewModel = DetailViewModel()
    
    //  MARK: - View Controller cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchProducts(id: id ?? 1)
    }
    
    //  MARK: - Initialization
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    //  MARK: - Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCollectionView() {
        collectionView.registerCell(ImagesCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchProducts(id: Int) {
        viewModel.fetchProduct(id: id) {
            guard let product = self.viewModel.product else { return }
            DispatchQueue.main.async {
                self.titleLabel.text = product.title
                self.priceLabel.text = "Price: \(product.price)$"
                self.descriptionLabel.text = "Description: \(product.description ?? "No Data")"
                self.brandLabel.text = "Brand: " + (product.brand ?? "No Data")
            }
            self.setPageControl()
            self.collectionView.reloadData()
        } failure: { error in
            self.alert(title: "Failure", message: error.localizedDescription)
        }
    }
    
    private func setPageControl() {
        self.pageControll.currentPage = 0
        self.pageControll.numberOfPages = self.viewModel.product?.images.count ?? 0
    }
}
//  MARK: - CollectionView Delegate & DataSource
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ImagesCollectionViewCell.self, for: indexPath)
        cell.setupImages(url: viewModel.product?.images[indexPath.item])
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

//  MARK: - CollectionViewCellLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
}
