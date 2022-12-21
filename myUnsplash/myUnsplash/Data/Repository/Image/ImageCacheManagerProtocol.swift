//
//  ImageCacheManagerProtocol.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/19.
//

import UIKit

protocol ImageCacheManagerProtocol {
    func stringToNSURL(_ url: String) -> NSURL?
    func checkCache(for key: NSURL) -> UIImage?
    func store(_ data: UIImage, _ forKey: NSURL)
    func loadImage(_ url: String, completion: @escaping (UIImage?) -> Void)
}
