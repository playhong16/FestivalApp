//
//  NetworkResource.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/10.
//

import UIKit

struct NetworkResource {
    // MARK: - URL

    static var searchURL: String {
        baseURL + Path.searchFestival.rawValue + searchParameter + apiKey
    }
    
    static var detailInformationURL: String {
        baseURL + Path.detailInformation.rawValue + detailInfoParameter + apiKey
    }
    
    // MARK: - Base

    private static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    private static let baseURL = "https://apis.data.go.kr/B551011/KorService1/"
    
    // MARK: - Parameter

    private static let searchParameter = "?MobileOS=IOS&MobileApp=FestivalApp&_type=json&numOfRows=10&serviceKey="
    private static let detailInfoParameter = "?MobileOS=IOS&MobileApp=FestivalApp&_type=json&contentTypeId=15&serviceKey="
    
    // MARK: - Path

    enum Path: String {
        case searchFestival = "searchFestival1"
        case detailInformation = "detailInfo1"
    }
}
