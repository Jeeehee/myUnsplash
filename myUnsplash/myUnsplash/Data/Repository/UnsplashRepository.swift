//
//  UnsplashRepository.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/14.
//

import Foundation

final class UnsplashRepository<T: Decodable> {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func dataTask(url: URL?, method: HTTPMethod, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        guard let request = createURLRequest(url: url, method: method) else { return }
        
        session.dataTask(with: request) { data, response, error in
            guard self.checkError(data: data, response: response, error: error) == nil else { return }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    guard let decodedResponse = try? JSONDecoder().decode([T].self, from: data) else {
                        return
                    }
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure((.decodeFailed)))
                }
            }
            
        }.resume()
    }
    
    private func createURLRequest(url: URL?, method: HTTPMethod) -> URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        return request
    }
    
    private func checkError(data: Data?, response: URLResponse?, error: Error?) -> NetworkError? {
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
    
}
