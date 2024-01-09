//
//  NetworkManager.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/05.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("NetworkManager - ERROR: fetchImage(urlString:completion) 의 HTTP 응답 코드는 - \(response) 입니다.")
                return
            }

            guard let data = data else { return }
            let result = UIImage(data: data)
            completion(result)
        }
        task.resume()
    }
    
    func fetchFestival(completion: @escaping ([Festival]) -> Void) {
        let date = Date()
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYYMMDD"
        let todayString = dateFormmatter.string(from: date)
        print(todayString)
        let base = "https://apis.data.go.kr/B551011/KorService1/"
        let path = "searchFestival1?numOfRows=10&MobileOS=IOS&MobileApp=FestivalApp&_type=json&eventStartDate=\(todayString)&serviceKey="
        
        guard let url = URL(string: base + path + self.apiKey) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print(#function + "NetworkManager - HTTP 응답 코드는 - \(response) 입니다.")
                return
            }

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(FestivalWelcome.self, from: data)
                let festivalList = decodedData.response.body.items.festivals
                print(festivalList)
                completion(festivalList)
            } catch {
                print(#function + "NetworkManager - ERROR: \(error)")
            }
        }
        task.resume()
    }
    
    func fetchDetailInfomation(contentID: String, completion: @escaping (Information?) -> Void) {
        let urlString = "https://apis.data.go.kr/B551011/KorService1/detailInfo1?MobileOS=IOS&MobileApp=FestivalApp&_type=json&contentId=\(contentID)&contentTypeId=15&serviceKey="
        guard let url = URL(string: urlString + apiKey) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print(#function + "NetworkManager - ERROR: HTTP 응답 코드는 - \(response) 입니다.")
                return
            }

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(InformationWelcome.self, from: data)
                let information = decodedData.response.body.items.information
                completion(information.first)
            } catch {
                print(#function + "NetworkManager - ERROR: \(error)")
            }
        }
        task.resume()
    }
}
