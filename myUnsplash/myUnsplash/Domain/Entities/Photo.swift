//
//  Photo.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let width: Double
    let height: Double
    let url: String
    let user: String
}
