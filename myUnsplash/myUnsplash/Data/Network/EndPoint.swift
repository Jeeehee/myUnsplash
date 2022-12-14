//
//  EndPoint.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/14.
//

import Foundation

enum BaseURL {
    static var unsplashURL: URL {
        guard let url = URL(string: "https://api.unsplash.com") else { fatalError("Invalid URL") }
        return url
    }
}

protocol EndPoint {
    var baseURL: URL { get }
    var path: String { get }
}
