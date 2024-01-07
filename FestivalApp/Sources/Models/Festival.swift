//
//  Festival.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/03.
//

import Foundation

// NOTE: - json 파싱 결과 임의 기록

// MARK: - Welcome
struct Welcome: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let header: Header
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    let items: Items
    let numOfRows, pageNo, totalCount: Int
}

// MARK: - Items
struct Items: Codable {
    let item: [Festival]
}

// MARK: - Festival
struct Festival: Codable {
    let addr1: String
    let addr2: String
    let booktour: String
    let cat1: Cat1
    let cat2: Cat2
    let cat3: Cat3
    let contentid: String
    let contenttypeid: String
    let createdtime: String
    let eventStartDate: String
    let eventEndDate: String
    let imageURLString: String
    let firstimage2: String
    let cpyrhtDivCD: CpyrhtDivCD
    let mapx: String
    let mapy: String
    let mlevel: String
    let modifiedtime: String
    let areacode: String
    let sigungucode: String
    let tel: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case addr1, addr2, booktour, cat1, cat2, cat3, contentid, contenttypeid, createdtime, firstimage2
        case eventStartDate = "eventstartdate"
        case eventEndDate = "eventenddate"
        case imageURLString = "firstimage"
        case cpyrhtDivCD = "cpyrhtDivCd"
        case mapx, mapy, mlevel, modifiedtime, areacode, sigungucode, tel, title
    }
}

enum Cat1: String, Codable {
    case a02 = "A02"
}

enum Cat2: String, Codable {
    case a0207 = "A0207"
    case a0208 = "A0208"
}

enum Cat3: String, Codable {
    case a02070200 = "A02070200"
    case a02081300 = "A02081300"
}

enum CpyrhtDivCD: String, Codable {
    case empty = ""
    case type3 = "Type3"
}

// MARK: - Header
struct Header: Codable {
    let resultCode, resultMsg: String
}
