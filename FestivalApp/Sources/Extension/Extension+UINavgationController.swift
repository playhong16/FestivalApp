//
//  Extension+UINavgationController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/18.
//

import UIKit

extension UINavigationController {
    func setupBarAppearance() {
        let appearance: UINavigationBarAppearance = {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemTeal
            appearance.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.black
            ]
            return appearance
        }()
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
