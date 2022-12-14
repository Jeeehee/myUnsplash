//
//  NetworkError.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

enum NetworkError: Error {
    case responseError
    case invalidData
    case invalidURL
    case requestFailedError
    case decodeFailedError
    case encodingError
    case error(Error)
}
