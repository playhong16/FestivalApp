//
//  FestivalManager.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    var festivalList: [Festival] {
        return self._festivalList
    }
    private var _festivalList: [Festival] = []
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        networkManager.fetchFestival { items in
            self._festivalList = items
            completion()
        }
    }
    
}
