//
//  ImageCacheStorage.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/19.
//

import UIKit

final class ImageCacheStorage {
    private let cache = NSCache<NSURL, UIImage>()

    private func stringToNSURL(_ url: String) -> NSURL? {
        guard let url = NSURL(string: url) else { return nil }
        return url
    }
    
    private func checkCache(for key: NSURL) -> UIImage? {
        guard let cacheImage = cache.object(forKey: key) else { return nil }
        return cacheImage
    }
    
}

extension ImageCacheStorage: ImageCacheManager {
    func store(_ data: Data, _ forKey: NSURL) {
        guard let image = UIImage(data: data) else { return }
        cache.setObject(image, forKey: forKey)
    }
    
    func loadImage(_ url: String) {
        guard let cacheKey = stringToNSURL(url) else { return }
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            self.store(data, cacheKey)
        }
    }
}
