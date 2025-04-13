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
        setupCollectionView()
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
