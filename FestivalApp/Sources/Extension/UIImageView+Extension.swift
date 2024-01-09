//
//  UIImageView+Extension.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/05.
//

import UIKit

extension UIImageView {
    func loadImage(to urlString: String) {
        guard let url = URL(string: urlString) else {
            let image = UIImage(systemName: "photo")
            self.backgroundColor = .white
            self.tintColor = .lightGray
            self.image = image
            print("ERROR: 잘못된 URL 문자열입니다.")
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                        print("SUCEESS: 이미지 로드 성공!")
                    }
                }
            } catch {
                print("ERROR: 이미지 로드 실패! \(error)")
            }
        }
    }
}
