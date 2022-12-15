//
//  NetworkError.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

enum NetworkError: Error {
    case invalidStatusCode(statusCode: Int)
    case invalidURL
    case dataEmpty
    case reponseFailed
    case requestFailed
    case decodeFailed
    case encoding
    case error(Error)
}
