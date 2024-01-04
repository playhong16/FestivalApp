//
//  MockFestival.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/04.
//

import Foundation

struct MockFestival {
    let address: String
    let contentID: String
    let eventStartDate: String
    let eventEndDate: String
    let title: String
    let imageURLString: String
    let telephoneNumber: String
    
    static func makeMockList() -> [MockFestival]{
        let mockList: [MockFestival] = [
            self.init(
                address: "서울특별시 중구 충무로2가 명동역 3번출구 앞 상상광장",
                contentID: "3021762",
                eventStartDate: "20231021",
                eventEndDate: "20231022",
                title: "가을, 명동으로",
                imageURLString: "http://tong.visitkorea.or.kr/cms/resource/07/3021807_image2_1.jpg",
                telephoneNumber: "02-6084-7079"
            ),
            self.init(
                address: "서울특별시 중구 충무로2가 명동역 3번출구 앞 상상광장",
                contentID: "3021762",
                eventStartDate: "20231021",
                eventEndDate: "20231022",
                title: "가을, 명동으로",
                imageURLString: "http://tong.visitkorea.or.kr/cms/resource/07/3021807_image2_1.jpg",
                telephoneNumber: "02-6084-7079"
            ),
            self.init(
                address: "서울특별시 중구 충무로2가 명동역 3번출구 앞 상상광장",
                contentID: "3021762",
                eventStartDate: "20231021",
                eventEndDate: "20231022",
                title: "가을, 명동으로",
                imageURLString: "http://tong.visitkorea.or.kr/cms/resource/07/3021807_image2_1.jpg",
                telephoneNumber: "02-6084-7079"
            ),
        ]
        return mockList
    }
}


