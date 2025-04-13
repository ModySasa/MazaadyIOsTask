//
//  TagsCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class TagsCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topTagsLabel: UILabel!
    
    var tags : [Tag] = []
    private var selectedIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func configure(with tags : [Tag]) {
        self.tags = tags
        self.topTagsLabel.text = strings(key: .topTags)
        self.collectionView.reloadData()
        self.collectionView.layoutIfNeeded()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TagsItemCell", bundle: nil), forCellWithReuseIdentifier: "TagsItemCell")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        collectionView.collectionViewLayout = layout
    }
}

extension TagsCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsItemCell", for: indexPath) as! TagsItemCell
        cell.configure(with: tags[indexPath.item], index: indexPath.item, selectedIndex: selectedIndex)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (tags[indexPath.item].name ?? "").size(with: UIFont(name: "Nunito-Bold", size: 12)!)
        let itemWidth: CGFloat = itemSize.width + 46
        let itemHeight: CGFloat = itemSize.height + 8
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
}
