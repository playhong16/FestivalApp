//
//  UIImageView+Extension.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/05.
//

import UIKit

extension UIImageView {
    func setImage(to urlString: String) {
        guard let url = URL(string: urlString) else {
            let image = UIImage(systemName: "photo")
            self.backgroundColor = .white
            self.tintColor = .lightGray
            self.image = image
            print("ERROR: 잘못된 URL 문자열입니다.")
            return
        }
        
        DispatchQueue.global().async {
            let cachedKey = NSString(string: urlString)
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                    return
                }
            }
            
            NetworkManager.shared.fetchImage(urlString: urlString) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                        self.image = image
                    }
                }
            }
        }
    }
}
