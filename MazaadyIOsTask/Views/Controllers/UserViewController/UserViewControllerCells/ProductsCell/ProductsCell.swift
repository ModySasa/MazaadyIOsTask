//
//  ProductCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class ProductsCell: UITableViewCell {
    var products: [Product] = []
    
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
    }
    
    func configure(with products: [Product]) {
        self.products = products
        for (index, product) in products.enumerated() {
            if index % 3 == 0 {
                leadingProducts.append(product)
            } else if index % 3 == 1 {
                middleProducts.append(product)
            } else {
                trailingProducts.append(product)
            }
        }
        print("LEADING COUNTTTTT , \(leadingProducts.count)")
        print("TRAILING COUNTTTTT , \(trailingProducts.count)")
        print("MIDDLE COUNTTTTT , \(middleProducts.count)")
        loadCollection(collectionView)
        loadCollection(middleCollection)
        loadCollection(trailingCollection)
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


//import UIKit

class StaggeredFlowLayout: UICollectionViewFlowLayout {
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var rowHeights: [CGFloat] = []  // To track the total height of each row
    var products: [Product] = []

    // Called when the layout is transitioning
    override func prepareForTransition(to newLayout: UICollectionViewLayout) {
        super.prepareForTransition(to: newLayout)
        cache.removeAll()
        rowHeights.removeAll()
    }

    // This method is used to return layout attributes of the items in the given rect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                attributesInRect.append(attributes)
            }
        }
        
        return attributesInRect
    }

    // This method is called to invalidate layout attributes for specific items
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        return true
    }

    // This method is where we calculate the layout attributes for each item
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)!
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth: CGFloat = (screenWidth - 32 - 16) / 3
        var itemHeight: CGFloat = 180
        
        let product = products[indexPath.item]
        if product.offer != nil {
            itemHeight += (209 - 160)
        }
        if product.endDate != nil {
            itemHeight += (265 - 209)
        }
        
        let row = indexPath.item / 3
        let column = indexPath.item % 3
        
        // Calculate dynamic vertical offset
        var yOffset: CGFloat = 0
        if row > 0 {
            let previousRowHeight = rowHeights[row - 1] // Height of the previous row
            yOffset = previousRowHeight
        }

        // Update the height for this row
        if rowHeights.count <= row {
            rowHeights.append(itemHeight + minimumLineSpacing) // Add height for the first item in the row
        } else {
            rowHeights[row] += itemHeight + minimumLineSpacing // Add to the existing row height
        }

        // Set the new frame for the item, considering the dynamic yOffset
        attributes.frame = CGRect(x: (itemWidth + minimumInteritemSpacing) * CGFloat(column) + 16,
                                  y: yOffset,
                                  width: itemWidth,
                                  height: itemHeight)

        // Cache the attributes for reuse
        cache.append(attributes)
        
        return attributes
    }
}
