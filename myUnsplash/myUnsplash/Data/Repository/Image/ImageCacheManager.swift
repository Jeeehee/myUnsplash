//
//  ImageCacheManager.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/19.
//

import UIKit

final class ImageCacheManager {
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

extension ImageCacheManager: ImageCacheManagerProtocol {
    func store(_ data: UIImage, _ forKey: NSURL) {
        cache.setObject(data, forKey: forKey)
    }
    
    func loadImage(_ url: String, completion: @escaping (UIImage?) -> Void) {
        guard let cacheKey = stringToNSURL(url) else { return }
        guard let url = URL(string: url) else { return }
        
        guard checkCache(for: cacheKey) == nil else {
            completion(checkCache(for: cacheKey))
            return
        }
        
        let urlSession = URLSession(configuration: .ephemeral)
        
        urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self?.store(image, cacheKey)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
