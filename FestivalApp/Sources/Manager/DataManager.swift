//
//  FestivalManager.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

final class DataManager {
    
    static let shared = DataManager()
    
    var festivalList: [Festival] {
        return self._festivalList
    }
    
    var savedFestivals: [Festival] {
        return _savedFestivals
    }
    
    private var _festivalList: [Festival] = []
    private var _savedFestivals: [Festival] = []
    
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    func setupDatasFromAPI(completion: @escaping () -> Void) {
        networkManager.fetchFestival(pageNumber: networkManager.pageNumber) { result in
            switch result {
            case .success(let festivals):
                completion()
                self._festivalList += festivals
                print(self.networkManager.pageNumber)
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
    
    func saveFestival(_ festival: Festival) {
        _savedFestivals.append(festival)
        print(_savedFestivals)
    }
    
    func removeFestival(_ target: Festival) {
        _savedFestivals.removeAll { $0.contentid == target.contentid }
    }
}
