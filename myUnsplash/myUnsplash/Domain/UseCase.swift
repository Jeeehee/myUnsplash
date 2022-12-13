//
//  UseCase.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/11.
//

import Foundation

final class UseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func start(with account: Account, completion: @escaping (Result<String, KeyChainError>) -> Void) {
        repository.getKey(account: account.name) { (appKey: Result<String, KeyChainError>) in
            switch appKey {
            case let .success(key):
                completion(.success(key))
            case let .failure(error):
                completion(.failure(error))
                return
            }
        }
    }
}
