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
    
    func fetchFestivalsFromAPI(pageNumber: Int, completion: @escaping (Int, [Festival]) -> Void) {
        networkManager.requestFestivals(pageNumber: pageNumber) { result in
            switch result {
            case .success(let welcomeData):
                let nextPageNumber = welcomeData.response.body.pageNo + 1
                let festivals = welcomeData.response.body.items.festivals
                completion(nextPageNumber, festivals)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchFestivalDetailInfomationFromAPI(contentID: String, completion: @escaping (Information) -> Void) {
        networkManager.requestDetailInfomation(contentID: contentID) { result in
            switch result {
            case .success(let welcomeData):
                if let information = welcomeData.response.body.items.information.first {
                    completion(information)
                }
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
