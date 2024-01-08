//
//  Infomation.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/08.
//

import Foundation

// MARK: - Welcome
struct InformationWelcome: Codable {
    let response: InformationResponse
}

// MARK: - Response
struct InformationResponse: Codable {
    let header: InformationHeader
    let body: InformationBody
}

// MARK: - Body
struct InformationBody: Codable {
    let items: InformationData
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct InformationData: Codable {
    let information: [Information]
    
    enum CodingKeys: String, CodingKey {
        case information = "item"
    }
}

// MARK: - Item
struct Information: Codable {
    let contentid, contenttypeid, serialnum, infoname: String
    let infotext, fldgubun: String
}

// MARK: - Header
struct InformationHeader: Codable {
    let resultCode, resultMsg: String
}

