//
//  DetailInfomation.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/08.
//

import Foundation

// MARK: - Welcome
struct InfomationWelcome: Codable {
    let response: InfomationResponse
}

// MARK: - Response
struct InfomationResponse: Codable {
    let header: InfomationHeader
    let body: InfomationBody
}

// MARK: - Body
struct InfomationBody: Codable {
    let items: InfomationData
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct InfomationData: Codable {
    let infomation: [Infomation]
    
    enum CodingKeys: String, CodingKey {
        case infomation = "item"
    }
}

// MARK: - Item
struct Infomation: Codable {
    let contentid, contenttypeid, serialnum, infoname: String
    let infotext, fldgubun: String
}

// MARK: - Header
struct InfomationHeader: Codable {
    let resultCode, resultMsg: String
}

