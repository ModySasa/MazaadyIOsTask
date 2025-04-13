//
//  AdsItemCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class AdsItemCell: UICollectionViewCell {

    @IBOutlet weak var advImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with adv: Advertisement) {
        print("Ads image url: \(adv.image ?? "")")
        if let url = URL(string: adv.image ?? "") {
            downloadImage(url) { img in
                self.advImage.image = img
            }
        }
    }
}
