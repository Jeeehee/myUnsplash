//
//  UnsplashUseCase.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

final class UnsplashUseCase {
    private let repository: UnsplashRepositoryImpl

    init(repository: UnsplashRepositoryImpl) {
        self.repository = repository
    }
    
    func start<T: Decodable>(_ type: T.Type, url: URL?, method: HTTPMethod, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let request = repository.createURLRequest(url: url, method: method) else { return }
        
        repository.dataTask(T.self, request: request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.requestFailed))
            }
        }
    }
}
