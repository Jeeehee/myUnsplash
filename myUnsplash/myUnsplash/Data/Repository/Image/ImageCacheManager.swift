//
//  ImageCacheManager.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/19.
//

import UIKit

final class ImageCacheManager: ImageCacheManagerProtocol {
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }

    func stringToNSURL(_ url: String) -> NSURL? {
        guard let url = NSURL(string: url) else { return nil }
        return url
    }
    
    func checkCache(for key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
                            
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
        
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else { return }
            
            self?.store(image, cacheKey)
            
            DispatchQueue.main.async {
                completion(image)
            }
            
        }.resume()
    }
}
