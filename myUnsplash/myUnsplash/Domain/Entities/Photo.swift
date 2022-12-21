//
//  Photo.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: URLs
    let user: User
}

struct URLs: Decodable {
    let full: String
    let small: String
}

struct User: Decodable {
    let name: String
}
