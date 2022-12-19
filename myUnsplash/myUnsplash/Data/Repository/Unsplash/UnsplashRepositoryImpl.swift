//
//  UnsplashRepositoryImpl.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/14.
//

import Foundation

final class UnsplashRepositoryImpl: UnsplashRepository {
    private let session: URLSessionProtocol
    private var photos: Photos?
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func dataTask<T: Decodable>(_ type: T.Type, request: URLRequest, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, error in 
            guard self.errorCheck(data: data, response: response, error: error) == nil else { return }
            guard let data = data else { return }
            
            do {
                guard let decodedResponse = try? JSONDecoder().decode([T].self, from: data) else {
                    return
                }
                completion(.success(decodedResponse))
            } catch {
                completion(.failure((.decodeFailed)))
            }
            
        }.resume()
    }
    
    func createURLRequest(url: URL?, method: HTTPMethod) -> URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        return request
    }
    
    func errorCheck(data: Data?, response: URLResponse?, error: Error?) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .reponseFailed
        }
        
        guard (200 ... 299) ~= httpResponse.statusCode else {
            return .invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        
        guard data != nil else {
            return .dataEmpty
        }
        
        guard error == nil else {
            return .error(error?.localizedDescription as! Error)
        }
         
        return nil
    }
    
    func savePhotos<T: Decodable>(_ type: T.Type, data: [Photo]) {
        photos?.append(data)
    }
}
