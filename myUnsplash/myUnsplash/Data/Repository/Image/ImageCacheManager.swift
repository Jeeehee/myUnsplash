//
//  ImageCacheManager.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/19.
//

import Foundation

protocol ImageCacheManager {
    func store(_ data: Data, _ forKey: NSURL)
    func loadImage(_ url: String)
}
