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
        followingLabel.text = strings(key: .following)
        followingLabel.font = UIFont(name: "Nunito-Regular", size: 12)
        followingLabel.textColor = UIColor(named: "purple")
        
        followersLabel.text = strings(key: .followers)
        followersLabel.font = UIFont(name: "Nunito-Regular", size: 12)
        followersLabel.textColor = UIColor(named: "purple")
    }
    
    func configure(with profile: UserProfile) {
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
            downloadImage(imageUrl)
        }
    }
    
    func downloadImage(_ url: URL) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            DispatchQueue.main.async {
                self.userImage.image = image
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response,
                let image = UIImage(data: data)
            else { return }
            
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)
            
            DispatchQueue.main.async {
                self.userImage.image = image
            }
        }.resume()
    }
}
