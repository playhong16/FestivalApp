//
//  FestivalManager.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/07.
//

import UIKit

final class DataManager {
    
    static let shared = DataManager()

    var savedFestivals: [Festival] {
        return _savedFestivals
    }
    private var _savedFestivals: [Festival] = []
    
    private init() {}
    
    func saveFestival(_ festival: Festival) {
        _savedFestivals.append(festival)
        print(_savedFestivals)
    }
    
    func removeFestival(_ target: Festival) {
        _savedFestivals.removeAll { $0.contentid == target.contentid }
    }
}
