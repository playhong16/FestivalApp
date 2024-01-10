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
        networkManager.fetchFestival { result in
            switch result {
            case .success(let festivals):
                completion()
                self._festivalList = festivals
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func setupInfomationFromAPI(contentID: String,completion: @escaping (Information?) -> Void) {
        networkManager.fetchDetailInfomation(contentID: contentID) { result in
            switch result {
            case .success(let information):
                completion(information)
            case .failure(let error):
                print(error)
            }
        }
    }
}
