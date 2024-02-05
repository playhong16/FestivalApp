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
    var pageNumber = 1
    
    private init() {}
    
    // MARK: - Result

    typealias FestivalResult = Result<FestivalWelcome, NetworkError>
    typealias InformationResult = Result<InformationWelcome, NetworkError>
    
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

    func requestFestivals(pageNumber: Int, completion: @escaping (FestivalResult) -> Void) {
        let date = Date()
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYYMMDD"
        let todayString = dateFormmatter.string(from: date)
        let urlString = NetworkResource.searchURL + "&eventStartDate=\(todayString)" + "&pageNo=\(pageNumber)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        task(url, completion: completion)
    }
    
    // MARK: - Detail Information
    
    func requestDetailInfomation(contentID: String, completion: @escaping (InformationResult) -> Void) {
        let urlString = NetworkResource.detailInformationURL + "&contentId=\(contentID)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        task(url, completion: completion)
    }
    
    // MARK: - Task

    private func task<T>(_ url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) == false {
                completion(.failure(.responseError(statusCode: httpResponse.statusCode)))
                return
            }
            
            if let data = data {
                self?.parseJson(data, completion: completion)
                return
            }
        }
        task.resume()
    }
    
    // MARK: - Parse

    private func parseJson<T>(_ data: Data, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Decodable {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(NetworkError.jsonDecodingError(error: error)))
        }
    }
}
