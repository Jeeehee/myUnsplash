//
//  Photo.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

struct APIResponse: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Photo]
}

struct Photo: Decodable {
    let id: String
    let width: Int
    let height: Int
    let urls: URLs
    let user: User
}

struct URLs: Decodable {
    let full: URL
    let small: URL
}

struct User: Decodable {
    let name: String
}
