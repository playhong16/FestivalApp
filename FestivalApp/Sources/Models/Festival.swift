//
//  Festival.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import Foundation

// NOTE: - json 파싱 결과 임의 기록

// MARK: - Welcome
struct FestivalWelcome: Codable {
    let response: FestivalResponse
}

// MARK: - Response
struct FestivalResponse: Codable {
    let header: FestivalHeader
    let body: FestivalBody
}

// MARK: - Body
struct FestivalBody: Codable {
    let items: Festivals
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct Festivals: Codable {
    let festivals: [Festival]
    
    enum CodingKeys: String, CodingKey {
        case festivals = "item"
    }
}

// MARK: - Festival
struct Festival: Codable {
    let addr1: String
    let addr2: String
    let booktour: String
    let contentid: String
    let contenttypeid: String
    let createdtime: String
    let eventStartDate: String
    let eventEndDate: String
    let imageURLString: String
    let firstimage2: String
    let mapx: String
    let mapy: String
    let mlevel: String
    let modifiedtime: String
    let areacode: String
    let sigungucode: String
    let tel: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case addr1, addr2, booktour, contentid, contenttypeid, createdtime, firstimage2
        case eventStartDate = "eventstartdate"
        case eventEndDate = "eventenddate"
        case imageURLString = "firstimage"
        case mapx, mapy, mlevel, modifiedtime, areacode, sigungucode, tel, title
    }
}

// MARK: - Header
struct FestivalHeader: Codable {
    let resultCode, resultMsg: String
}
