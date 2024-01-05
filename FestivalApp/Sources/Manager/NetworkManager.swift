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
    
    func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("ERROR: NetworkManager - fetchImage(urlString:completion) HTTP 응답 코드는 - \(response) 입니다.")
                return
            }

            guard let data = data else { return }
            let result = UIImage(data: data)
            completion(result)
        }
        task.resume()
    }
}
