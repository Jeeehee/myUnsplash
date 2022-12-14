//
//  HTTPMethod.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

enum HTTPMethod: String {
    case get
    case put
    case post
    case delete
    
    var value: String {
        self.rawValue.uppercased()
    }
}
