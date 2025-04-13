//
//  AdsCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class AdsCell: UITableViewCell {
    var ads: [Advertisement] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView() // Added setupCollectionView call
        setupCompositionalLayout()
    }
    
    func configure(with ads: [Advertisement]) {
        self.ads = ads
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdsItemCell", bundle: nil), forCellWithReuseIdentifier: "AdsItemCell")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = layout
    }
    
    private func setupCompositionalLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AdsItemCell", bundle: nil), forCellWithReuseIdentifier: "AdsItemCell")
        
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

extension AdsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsItemCell", for: indexPath) as! AdsItemCell
        cell.configure(with: ads[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth: CGFloat = screenWidth - 32
        let itemHeight: CGFloat = 150
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
