//
//  NetworkError.swift
//  FestivalApp
//
//  Created by playhong on 2024/01/10.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError(statusCode: Int)
    case jsonDecodingError(error: Error)
}
