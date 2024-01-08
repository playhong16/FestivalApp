//
//  DetailInfomation.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/08.
//

import Foundation

// MARK: - Welcome
struct DetailInfomationWelcome: Codable {
    let response: DetailInfomationResponse
}

// MARK: - Response
struct DetailInfomationResponse: Codable {
    let header: DetailInfomationHeader
    let body: DetailInfomationBody
}

// MARK: - Body
struct DetailInfomationBody: Codable {
    let items: DetailInfomationDatas
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct DetailInfomationDatas: Codable {
    let infomation: [DetailInfomation]
    
    enum CodingKeys: String, CodingKey {
        case infomation = "item"
    }
}

// MARK: - Item
struct DetailInfomation: Codable {
    let contentid, contenttypeid, serialnum, infoname: String
    let infotext, fldgubun: String
}

// MARK: - Header
struct DetailInfomationHeader: Codable {
    let resultCode, resultMsg: String
}

