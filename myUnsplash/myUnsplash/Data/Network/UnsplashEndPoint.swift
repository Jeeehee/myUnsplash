//
//  UnsplashEndPoint.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/14.
//

import Foundation

enum UnsplashEndPoint: EndPoint {
    case list
    case search
}

extension UnsplashEndPoint {
    var baseURL: URL {
        return BaseURL.unsplashURL
    }
    
    var path: String {
        switch self {
        case .list: return "/photos"
        case .search: return "/search/photos"
        }
    }
}
