//
//  UnsplashRepository.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

protocol UnsplashRepository {
    func createURLRequest(url: URL?, method: HTTPMethod) -> URLRequest?
    func errorCheck(data: Data?, response: URLResponse?, error: Error?) -> NetworkError?
}
