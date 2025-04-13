//
//  ProductCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class ProductsCell: UITableViewCell {
    var products: [Product] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView() // Added setupCollectionView call
//        setupStaggeredCollectionView()
//        setupCompositionalLayout()
    }
    
    func configure(with products: [Product]) {
        self.products = products
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellWithReuseIdentifier: "ProductItemCell")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = layout
    }
    
    private func setupStaggeredCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellWithReuseIdentifier: "ProductItemCell")
        
        let staggeredLayout = StaggeredFlowLayout()
        staggeredLayout.products = products
        staggeredLayout.scrollDirection = .vertical
        staggeredLayout.minimumLineSpacing = 8
        staggeredLayout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = staggeredLayout
    }
    
    private func setupCompositionalLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellWithReuseIdentifier: "ProductItemCell")
        
        // Create a compositional layout
        let layout = createStaggeredLayout()
        collectionView.collectionViewLayout = layout
    }
    
    private func createStaggeredLayout() -> UICollectionViewLayout {
        // Define the item size (dynamic based on product height)
        let itemProvider: NSCollectionLayoutItem = {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            return item
        }()

        // Define the group to hold 3 items in a row
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        
        // Define a horizontal group with 3 items
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [itemProvider, itemProvider, itemProvider] // 3 items in a row
        )

        // Create a section using the group
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

        // Create the compositional layout with the section
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ProductsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        cell.configure(with: products[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let product = products[indexPath.item]
        let itemWidth: CGFloat = (screenWidth - 32 - 16) / 3
        var itemHeight: CGFloat = 180
        if(product.offer != nil) {
            itemHeight += (209 - 160)
        }
        if(product.endDate != nil) {
            itemHeight += (265 - 209)
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
