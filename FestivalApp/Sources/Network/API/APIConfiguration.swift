//
//  APIConfiguration.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation



struct APIConfiguration {
    typealias Parameters = [String: String]
    
    var baseURL: URL
    var path: String
    var httpMethod: HTTPMethod
    var parameters: Parameters?
    var url: URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path = path
        
        var queryItems: [URLQueryItem] = []
        parameters?.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents?.percentEncodedQueryItems = queryItems
        
        return urlComponents?.url
    }
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return request
    }
    
    init(baseURL: URL, path: String, httpMethod: HTTPMethod, parameters: Parameters? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
