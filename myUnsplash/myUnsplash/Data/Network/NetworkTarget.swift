//
//  NetworkTarget.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/14.
//

import Foundation

enum NetworkTarget: EndPoint {
    case list(page: Int)
    case search(query: String, page: Int)
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
        case .list(_): return "/photos"
        case .search(_, _): return "/search/photos"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .list(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)")]
        case .search(let query, let page):
            return [
                URLQueryItem(name: "client_id", value: "i33Mzo-wnF-1ZKpWLVqe6cSmd0W0auo9vs2UuLJI2SU"),
                URLQueryItem(name: "query", value: "\(query)"),
                URLQueryItem(name: "page", value: "\(page)")]
        }
    }
    
    var url: URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
}
