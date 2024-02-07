//
//  APIError.swift
//  FestivalApp
//
//  Created by playhong on 2024/02/07.
//

import Foundation

enum APIError: Error {
    case noRequest
    case noData
    case responseError(statusCode: Int)
    case jsonDecodingError
    case unknown
}
