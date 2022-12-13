//
//  Storage.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/11.
//

import Foundation

final class Storage {
    static let shared = Storage()
    
    var key: [String: String]?
    
    private init() {}
}
