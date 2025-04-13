//
//  ProfileCell.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with profile: UserProfile) {
        followingLabel.text = strings(key: .following)
        followingLabel.font = UIFont(name: "Nunito-Regular", size: 12)
        followingLabel.textColor = UIColor(named: "purple")
        
        followersLabel.text = strings(key: .followers)
        followersLabel.font = UIFont(name: "Nunito-Regular", size: 12)
        followersLabel.textColor = UIColor(named: "purple")
        
        userName.text = profile.name
        userName.font = UIFont(name: "Nunito-Bold", size: 18)
        userName.textColor = UIColor(named: "text_black")
        
        userEmail.text = "@\(profile.userName ?? "")"
        userEmail.font = UIFont(name: "Nunito-Regular", size: 14)
        userEmail.textColor = UIColor(named: "text_black")
        
        followingCount.text = "\(profile.followingCount ?? 0)"
        followingCount.font = UIFont(name: "Nunito-Bold", size: 14)
        followingCount.textColor = UIColor(named: "text_black")
        
        followersCount.text = "\(profile.followersCount ?? 0)"
        followersCount.font = UIFont(name: "Nunito-Bold", size: 14)
        followersCount.textColor = UIColor(named: "text_black")
        
        
        userAddress.text = "\(profile.countryName ?? ""), \(profile.cityName ?? "")"
        userAddress.font = UIFont(name: "Nunito-Regular", size: 12)
        userAddress.textColor = UIColor(named: "gray2")
        
        if let imageUrl = URL(string: profile.image ?? "") {
            downloadImage(imageUrl) { image in
                self.userImage.image = image
            }
        }
    }
    
    
}
