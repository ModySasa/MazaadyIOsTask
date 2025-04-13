//
//  DownloadImage.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit
extension UIView {
    func downloadImage(_ url: URL , onSuccess : @escaping (UIImage?)-> Void) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
            DispatchQueue.main.async {
                onSuccess(image)
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
                onSuccess(image)
            }
        }.resume()
    }
}
