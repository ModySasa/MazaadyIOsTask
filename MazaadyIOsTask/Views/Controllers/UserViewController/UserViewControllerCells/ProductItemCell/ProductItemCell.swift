//
//  ProductItemCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class ProductItemCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemPriceCurrency: UILabel!
    
    @IBOutlet weak var priceOfferLabel: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    
    @IBOutlet weak var lotLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with product: Product) {
        
        priceLabel.text = strings(key: .price)
        priceLabel.font = UIFont(name: "Nunito-Regular", size: 10)
        priceLabel.textColor = UIColor(named: "gray3")
        
        setProductImage(product)
        setProductName(product)
        setProductPrice(product)
        
        if let offer = product.offer {
            priceOfferLabel.text = strings(key: .priceOffer)
            priceOfferLabel.font = UIFont(name: "Nunito-Regular", size: 10)
            priceOfferLabel.textColor = UIColor(named: "gray3")
            
            setProductOffer(product , offer: offer)
        } else {
            priceOfferLabel.isHidden = true
            offerPrice.isHidden = true
        }
        
        if let endDate = product.endDate {
            setProductCountDown(product , product.countdownComponents)
        } else {
            lotLabel.isHidden = true
        }
        
    }
    
    func setProductImage(_ product: Product) {
        if let imageUrl = URL(string: product.image ?? "") {
            downloadImage(imageUrl) { image in
                self.productImage.image = image
            }
        }
    }
    
    func setProductName(_ product:Product) {
        productName.text = product.name ?? ""
        productName.font = UIFont(name: "Nunito-Regular", size: 12)
        productName.textColor = UIColor(named: "gray1")
    }
    
    func setProductPrice(_ product:Product) {
        itemPrice.text = "\(product.price ?? 0)"
        itemPrice.font = UIFont(name: "Nunito-Bold", size: 12)
        itemPrice.textColor = UIColor(named: "gray1")
        
        itemPriceCurrency.text = product.currency
        itemPriceCurrency.font = UIFont(name: "Nunito-Bold", size: 12)
        itemPriceCurrency.textColor = UIColor(named: "gray1")
    }
    
    func setProductOffer(_ product:Product , offer:Double) {
        let currentPrice = "\(offer)" + " " + (product.currency ?? "")
        
        let oldPrice = "\(product.price ?? 0)" + " " + (product.currency ?? "")
        
        let attributedString = NSMutableAttributedString(string: currentPrice + " " + oldPrice)
        
        let currentPriceRange = NSRange(location: 0, length: currentPrice.count)
        attributedString.addAttribute(.font, value: UIFont(name: "Nunito-Bold", size: 12)!, range: currentPriceRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "gray1")!, range: currentPriceRange)  // Green color for current price

        
        let oldPriceRange = NSRange(location: currentPrice.count + 1, length: oldPrice.count)
        attributedString.addAttribute(.font, value: UIFont(name: "Nunito-Regular", size: 8)!, range: oldPriceRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "app_red")!, range: oldPriceRange)
        attributedString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: oldPriceRange)
        
        offerPrice.attributedText = attributedString
    }
    
    func setProductCountDown(_ product : Product , _ countDownComponents : (days: Int, hours: Int, minutes: Int)?) {
        
    }
}
