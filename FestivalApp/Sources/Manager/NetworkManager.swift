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
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    private let base = "https://apis.data.go.kr/B551011/KorService1/"
    
    typealias FestivalResult = Result<[Festival], NetworkError>
    typealias InformationResult = Result<Information?, NetworkError>
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                return
            }

            guard let data = data else { return }
            let result = UIImage(data: data)
            completion(result)
        }
        task.resume()
    }
    
    func fetchFestival(completion: @escaping (FestivalResult) -> Void) {
        let date = Date()
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYYMMDD"
        let todayString = dateFormmatter.string(from: date)
        let path = "searchFestival1?numOfRows=10&MobileOS=IOS&MobileApp=FestivalApp&_type=json&eventStartDate=\(todayString)&serviceKey="
        
        guard let url = URL(string: base + path + apiKey) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) == false {
                completion(.failure(.responseError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(FestivalWelcome.self, from: data)
                let festivalList = decodedData.response.body.items.festivals
                completion(.success(festivalList))
            } catch {
                completion(.failure(.jsonDecodingError(error: error)))
            }
        }
        task.resume()
    }
    
    func fetchDetailInfomation(contentID: String, completion: @escaping (InformationResult) -> Void) {
        let path = "detailInfo1?MobileOS=IOS&MobileApp=FestivalApp&_type=json&contentId=\(contentID)&contentTypeId=15&serviceKey="
        guard let url = URL(string: base + path + apiKey)
        else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) == false {
                completion(.failure(.responseError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(InformationWelcome.self, from: data)
                let information = decodedData.response.body.items.information
                completion(.success(information.first))
            } catch {
                completion(.failure(.jsonDecodingError(error: error)))
            }
        }
        task.resume()
    }
}
