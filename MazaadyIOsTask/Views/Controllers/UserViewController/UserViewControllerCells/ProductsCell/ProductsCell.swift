//
//  ProductCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class ProductsCell: UITableViewCell {
    @IBOutlet weak var searchButton: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchTabView: UIView!
    var didTapSearch: ((String) -> Void)?
    
    var leadingProducts: [Product] = []
    var middleProducts: [Product] = []
    var trailingProducts: [Product] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var middleCollection: UICollectionView!
    @IBOutlet weak var trailingCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView(collectionView)
        setupCollectionView(middleCollection)
        setupCollectionView(trailingCollection)
        searchField.placeholder = strings(key: .search)
        addPaddingToSearchField()
    }
    
    func configure(with products: [Product] , didTabSearch : @escaping (String) -> Void) {
        leadingProducts = []
        middleProducts = []
        trailingProducts = []
        self.didTapSearch = didTabSearch
        for (index, product) in products.enumerated() {
            if index % 3 == 0 {
                leadingProducts.append(product)
            } else if index % 3 == 1 {
                middleProducts.append(product)
            } else {
                trailingProducts.append(product)
            }
        }
        loadCollection(collectionView)
        loadCollection(middleCollection)
        loadCollection(trailingCollection)
        
        setViewsWithSelectors(
            .init(arrayLiteral:
                    .init(searchTabView, #selector(searchTapped))
                 )
        )
    }
    
    func loadCollection(_ collectionView : UICollectionView) {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    private func setupCollectionView(_ collectionView : UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellWithReuseIdentifier: "ProductItemCell")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = layout
    }
    
    //MARK: SEARCH
    @objc func searchTapped(){
        if let didTapSearch {
            didTapSearch(searchField.text ?? "")
            searchField.text = ""
        }
    }
    
    private func addPaddingToSearchField() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: searchField.frame.height))
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        searchField.rightView = paddingView
        searchField.rightViewMode = .always
    }
    
}

extension ProductsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.middleCollection {
            return middleProducts.count
        } else if collectionView == self.trailingCollection {
            return trailingProducts.count
        } else {
            return leadingProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.middleCollection  , middleProducts.count > indexPath.item  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
            cell.configure(with: middleProducts[indexPath.item])
            return cell
        } else if collectionView == self.trailingCollection , trailingProducts.count > indexPath.item {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
            cell.configure(with: trailingProducts[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
            cell.configure(with: leadingProducts[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth: CGFloat = (screenWidth - 32 - 16) / 3
        var itemHeight: CGFloat = 180
        
        if (collectionView == self.middleCollection) {
            if(middleProducts.count > indexPath.item) {
                let product = middleProducts[indexPath.item]
                if(product.offer != nil) {
                    itemHeight += (209 - 160)
                }
                if(product.endDate != nil) {
                    itemHeight += (265 - 209)
                }
            }
        } else if (collectionView == self.trailingCollection) {
            if(trailingProducts.count > indexPath.item) {
                let product = trailingProducts[indexPath.item]
                if(product.offer != nil) {
                    itemHeight += (209 - 160)
                }
                if(product.endDate != nil) {
                    itemHeight += (265 - 209)
                }
            }
        } else {
            let product = leadingProducts[indexPath.item]
            if(product.offer != nil) {
                itemHeight += (209 - 160)
            }
            if(product.endDate != nil) {
                itemHeight += (265 - 209)
            }
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
