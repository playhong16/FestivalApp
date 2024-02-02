//
//  Router.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/02.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case fetch = "FETCH"
    case delete = "DELETE"
}

typealias Parameters = [String: String]
typealias HTTPHeaders = [String: String]

enum Router {
    case getFestival
    case getDetailFestival
}

extension Router {
    var baseURL: URL {
        let urlString = "https://apis.data.go.kr"
        guard let url = URL(string: urlString) else { fatalError("baseURL 존재하지 않음") }
        return url
    }
    
    var path: String {
        switch self {
        case .getFestival:
            return "/B551011/KorService1/searchFestival1"
        case .getDetailFestival:
            return "/B551011/KorService1/detailInfo1"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .getFestival:
            return [
                "MobileOS": "IOS",
                "MobileApp": "FestivalAPP",
                "_type": "json",
                "serviceKey": NetworkResource.apiKey,
                "numOfRows": "10",
                "eventStartDate": "20240202"
            ]
        case .getDetailFestival:
            return [
                "MobileOS": "IOS",
                "MobileApp": "FestivalAPP",
                "_type": "json",
                "serviceKey": NetworkResource.apiKey,
                "contentTypeId": "15"
            ]
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponent?.path = path
        
        var queryItems: [URLQueryItem] = []
        parameters?.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponent?.percentEncodedQueryItems = queryItems
        
        let url = urlComponent?.url
        guard let url = url else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
