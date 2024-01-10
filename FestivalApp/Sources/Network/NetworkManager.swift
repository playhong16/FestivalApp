//
//  NetworkManager.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/05.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    private init() {}
    
    // MARK: - Result

    typealias FestivalResult = Result<[Festival], NetworkError>
    typealias InformationResult = Result<Information?, NetworkError>
    
    // MARK: - Image

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
    
    // MARK: - Festivals

    func fetchFestival(completion: @escaping (FestivalResult) -> Void) {
        let date = Date()
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYYMMDD"
        let todayString = dateFormmatter.string(from: date)
        let urlString = NetworkResource.searchURL + "&eventStartDate=\(todayString)"
        
        guard let url = URL(string: urlString) else {
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
    
    // MARK: - Detail Information

    func fetchDetailInfomation(contentID: String, completion: @escaping (InformationResult) -> Void) {
        let urlString = NetworkResource.detailInformationURL + "&contentId=\(contentID)"
        guard let url = URL(string: urlString)
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
