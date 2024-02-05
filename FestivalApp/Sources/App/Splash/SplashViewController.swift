//
//  SplashViewController.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/05.
//

import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    @IBOutlet private weak var lottieAnimationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lottieAnimationView.play { _ in
            let viewController = MainTabBarController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as?
                UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window.rootViewController = viewController
            }
        }
    }
}
