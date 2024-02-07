//
//  API.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation

typealias Parameters = [String: String]

protocol APIConfiguration {
    associatedtype ResponseType: Decodable
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var url: URL? { get }
    var request: URLRequest? { get }
}

extension API {
    var baseURL: String {
        return "https://apis.data.go.kr"
    }
    
    var url: URL? {
        guard let url = URL(string: self.baseURL) else { return nil }
        
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponent?.path = path
        
        var queryItems: [URLQueryItem] = []
        parameters?.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponent?.percentEncodedQueryItems = queryItems
        
        return urlComponent?.url
    }
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if self.httpMethod == .get {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
