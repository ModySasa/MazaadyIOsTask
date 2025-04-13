//
//  TabsCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

class TabsCell: UITableViewCell {
    @IBOutlet weak var productsLabel: UILabel!
    @IBOutlet weak var productsSelected: UIView!
    @IBOutlet weak var productsView: UIView!
    
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var reviewsSelected: UIView!
    @IBOutlet weak var reviewsView: UIView!
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followersSelected: UIView!
    @IBOutlet weak var followersView: UIView!
    
    var onTabSelected : ((Tab) -> Void)?
    
    var isFirstClick : Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productsLabel.text = strings(key: .products)
        reviewsLabel.text = strings(key: .reviews)
        followersLabel.text = strings(key: .followers)
        
        productsSelected.backgroundColor = UIColor(named: "purple")
        reviewsSelected.backgroundColor = UIColor(named: "purple")
        followersSelected.backgroundColor = UIColor(named: "purple")
    }
    
    enum Tab : String {
        case products = "products"
        case reviews = "reviews"
        case followers = "followers"
    }
    
    func didTapOnTab(tab : Tab) {
        productsSelected.isHidden = true
        reviewsSelected.isHidden = true
        followersSelected.isHidden = true
        
        switch tab {
        case .products:
            productsSelected.isHidden = false
            productsLabel.font = UIFont(name: "Nunito-Bold", size: 14)
            productsLabel.textColor = UIColor(named: "purple")
            
            reviewsLabel.font = UIFont(name: "Nunito-Regular", size: 14)
            reviewsLabel.textColor = UIColor(named: "gray3")
            
            
            followersLabel.font = UIFont(name: "Nunito-Regular", size: 14)
            followersLabel.textColor = UIColor(named: "gray3")
        case .reviews:
            reviewsSelected.isHidden = false
            productsLabel.font = UIFont(name: "Nunito-Regular", size: 14)
            productsLabel.textColor = UIColor(named: "gray3")
            
            reviewsLabel.font = UIFont(name: "Nunito-Bold", size: 14)
            reviewsLabel.textColor = UIColor(named: "purple")
            
            followersLabel.font = UIFont(name: "Nunito-Regular", size: 14)
            followersLabel.textColor = UIColor(named: "gray3")
        case .followers:
            followersSelected.isHidden = false
            productsLabel.font = UIFont(name: "Nunito-Regular", size: 14)
            productsLabel.textColor = UIColor(named: "gray3")
            
            reviewsLabel.font = UIFont(name: "Nunito-Regular", size: 14)
            reviewsLabel.textColor = UIColor(named: "gray3")
            
            followersLabel.font = UIFont(name: "Nunito-Bold", size: 14)
            followersLabel.textColor = UIColor(named: "purple")
            
        }
        if let onTabSelected {
            onTabSelected(tab)
            isFirstClick = false
        }
    }
    
    func configure(onTabSelected : @escaping (Tab) -> Void){
        self.onTabSelected = onTabSelected
        setViewsWithSelectors(
            .init(arrayLiteral:
                    .init(productsView, #selector(selectProducts)),
                  .init(reviewsView, #selector(selectReviews)),
                  .init(followersView, #selector(selectFollowers))
                 )
        )
        if(isFirstClick) {
            selectProducts()
        }
    }
    
    @objc func selectProducts(){
        didTapOnTab(tab: .products)
    }
    
    @objc func selectReviews(){
        didTapOnTab(tab: .reviews)
    }
    
    @objc func selectFollowers(){
        didTapOnTab(tab: .followers)
    }
}
