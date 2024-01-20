//
//  MainTabBarController.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupItems()
    }
    
    private func configure() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .customSky
    }
    
    private func setupItems() {
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let savedFestivalVC = UINavigationController(rootViewController: SavedFestivalViewController())
        savedFestivalVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "heart"), tag: 1)
        
        self.viewControllers = [searchVC, savedFestivalVC]
    }
}
