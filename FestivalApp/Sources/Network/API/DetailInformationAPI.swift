//
//  DetailInformationAPI.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation

struct DetailInformationAPI: API {
    typealias ResponseType = InformationWelcome
    var configuration: APIConfiguration
    
    init(contentID: String) {
        self.configuration = APIConfiguration(baseURL: APIResource.baseURL,
                                              path: "/B551011/KorService1/detailInfo1",
                                              httpMethod: .get,
                                              parameters: [
                                                "MobileOS": "IOS",
                                                "MobileApp": "FestivalAPP",
                                                "_type": "json",
                                                "serviceKey": APIResource.apiKey,
                                                "contentTypeId": "15",
                                                "contentId": contentID
                                              ])
    }
}
