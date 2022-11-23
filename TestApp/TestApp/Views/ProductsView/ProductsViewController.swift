//
//  ViewController.swift
//  TestApp
//
//  Created by Владимир on 09.11.2022.
//

import UIKit

class ProductsViewController: UIViewController, Transition {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var viewModel = ProductsViewModel()
    
    //  MARK: - View Controller cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchProducts()
    }
    
    //  MARK: - Methods
    private func setupCollectionView() {
        collectionView.registerCell(ProductsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func productDetailTransition(id: Int) {
        let vc = DetailViewController.instantiate()
        vc.id = id
        vc.title = "ProductDetail"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func fetchProducts() {
        viewModel.fetchProducts {
            self.collectionView.reloadData()
        } failure: { error in
            self.alert(title: "Failure", message: error.localizedDescription)
        }
    }
}
//  MARK: - CollectionView Delegate & DataSource
extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ProductsCollectionViewCell.self, for: indexPath)
        cell.accessories = [.disclosureIndicator()]
        cell.setView(url: viewModel.products[indexPath.item].thumbnail, titleText: viewModel.products[indexPath.item].title, categoryText: viewModel.products[indexPath.item].category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        productDetailTransition(id: viewModel.products[indexPath.item].id)
    }
}
//  MARK: - CollectionViewCellLayout
extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: self.view.bounds.width / 2)
    }
}
