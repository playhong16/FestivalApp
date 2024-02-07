//
//  APIClient.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation

struct APIClient {
    static let shared = APIClient(session: URLSession.shared)
    
    typealias RequestResult = (Result<Data, APIError>) -> Void
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func reqeust(_ request: URLRequest?, completionHandler: @escaping RequestResult) {
        guard let request = request else {
            completionHandler(.failure(APIError.noRequest))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(APIError.noData))
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(data))
            }
        }.resume()
    }
}
