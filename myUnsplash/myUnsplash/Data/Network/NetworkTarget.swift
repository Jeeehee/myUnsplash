//
//  NetworkTarget.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/14.
//

import Foundation

enum NetworkTarget: EndPoint {
    case list
    case search
}

extension NetworkTarget {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.unsplash.com"
    }
    
    var path: String {
        switch self {
        case .list: return "/photos"
        case .search: return "/search/photos"
        }
    }
    
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: "i33Mzo-wnF-1ZKpWLVqe6cSmd0W0auo9vs2UuLJI2SU")
        ]
        return urlComponent.url
    }
}
