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
    
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
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
    
    func fetchFestival(urlString: String, completion: @escaping ([Item]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("NetworkManager - ERROR: fetchFestival(urlString:completion) 의 HTTP 응답 코드는 - \(response) 입니다.")
                return
            }

            guard let data = data else { return }
            print(String(decoding: data, as: UTF8.self))
            
            do {
                let decoder = JSONDecoder()
                let welcome = try decoder.decode(Welcome.self, from: data)
            } catch {
                print("NetworkManager - ERROR: fetchFestival(urlString:completion) \(error)")
            }
        }
        task.resume()
    }
}
