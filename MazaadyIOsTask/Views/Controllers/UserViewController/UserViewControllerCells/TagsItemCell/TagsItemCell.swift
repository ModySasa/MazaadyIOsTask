//
//  TagsItemCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class TagsItemCell: UICollectionViewCell {
    
    @IBOutlet weak var tagName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with tag: Tag, index: Int, selectedIndex: Int) {
        tagName.text = tag.name ?? ""
        
        if index == selectedIndex {
            setSelected()
        } else {
            setUnSelected()
        }
    }
    
    func setSelected() {
        tagName.font = UIFont(name: "Nunito-Bold", size: 12)
        tagName.textColor = UIColor(named: "orange1")
        
        tagName.layer.cornerRadius = 10
        tagName.layer.borderWidth = 1
        tagName.layer.borderColor = UIColor(named: "orange1")!.cgColor
        
    }
    
    func setUnSelected() {
        tagName.font = UIFont(name: "Nunito-Bold", size: 12)
        tagName.textColor = UIColor(named: "text_black")
        
        tagName.layer.cornerRadius = 10
        tagName.layer.borderWidth = 0
    }
}
