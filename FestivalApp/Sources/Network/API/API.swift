//
//  API.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation

protocol API {
    associatedtype ResponseType: Decodable
    typealias ResponseResult = (Result<ResponseType, APIError>) -> Void
    var configuration: APIConfiguration { get }
}

extension API {
    func execute(using client: APIClient = APIClient.shared,
               completionHandler: @escaping ResponseResult) {
        client.reqeust(configuration.urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(ResponseType.self, from: data)
                    completionHandler(.success(decodedData))
                } catch {
                    completionHandler(.failure(.jsonDecodingError))
                }
            case .failure:
                completionHandler(.failure(.noData))
            }
        }
    }
}
