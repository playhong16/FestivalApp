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
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [
                .font: UIFont.boldSystemFont(ofSize: 20),
                .foregroundColor: UIColor.black
            ]
            return appearance
        }()
        
        appearance.titlePositionAdjustment = UIOffset(horizontal: -(view.frame.width / 2.5),
                                                      vertical: 0)
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
