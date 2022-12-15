//
//  RepositoryImpl.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/11.
//

import Foundation

final class RepositoryImpl: Repository {
    private let storage = Storage.shared
    private let service = Service()
    
    func getKey(account: String, completion: @escaping (Result<String, KeyChainError>) -> Void ) {
        service.get(account: account) { (key: Result<String, KeyChainError>) in
            switch key {
            case let .success(key):
                self.setKey(account: account, key: key)
                self.storage.key?[account] = key
                completion(.success(key))
                
            case let .failure(error):
                completion(.failure(.unexpectedPasswordData))
            }
        }
    }
    
    func saveKey(account: String, key: String) {
        service.save(account: account, key: key)
    }
    
    func setKey(account: String, key: String) {
        storage.key?[account] = key
    }
}
