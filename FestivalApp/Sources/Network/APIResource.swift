//
//  APIResource.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/10.
//

import UIKit

struct APIResource {
    static let baseURL: URL = URL(string: "https://apis.data.go.kr")!
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    static var todayString: String {
        let date = Date()
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYYMMDD"
        let todayString = dateFormmatter.string(from: date)
        return todayString
    }
}
