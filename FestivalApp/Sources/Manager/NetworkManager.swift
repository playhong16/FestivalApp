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
    private let urlString = "https://apis.data.go.kr/B551011/KorService1/searchFestival1?numOfRows=10&MobileOS=IOS&MobileApp=FestivalApp&_type=json&eventStartDate=20230103&serviceKey="
    
    
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
        guard let url = URL(string: self.urlString + self.apiKey) else { return }
        print(url)
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("NetworkManager - ERROR: fetchFestival(urlString:completion) 의 HTTP 응답 코드는 - \(response) 입니다.")
                return
            }

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Welcome.self, from: data)
                let festivalList = decodedData.response.body.items.item
                print(festivalList)
                completion(festivalList)
            } catch {
                print("NetworkManager - ERROR: fetchFestival(urlString:completion) \(error)")
            }
        }
        task.resume()
    }
}
