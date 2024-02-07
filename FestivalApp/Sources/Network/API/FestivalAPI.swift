//
//  FestivalAPI.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation

struct FestivalAPI: API {
    typealias ResponseType = FestivalWelcome
    var configuration: APIConfiguration
    
    init(eventStartDate: String) {
        self.configuration = APIConfiguration(baseURL: APIResource.baseURL,
                                              path: "/B551011/KorService1/searchFestival1",
                                              httpMethod: .get,
                                              parameters: [
                                                 "MobileOS": "IOS",
                                                 "MobileApp": "FestivalAPP",
                                                 "_type": "json",
                                                 "serviceKey": APIResource.apiKey,
                                                 "numOfRows": "20",
                                                 "eventStartDate": eventStartDate
                                              ])
    }
}
