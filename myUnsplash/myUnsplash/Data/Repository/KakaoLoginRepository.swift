//
//  KakaoLoginRepository.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/11.
//

import Foundation

final class KakaoLoginRepository {
    private let storage = Storage.shared
    private let service = Service()
    private let account = "Kakao_Login"
    
    func getAppKey(completion: @escaping (Result<String, KeyChainError>) -> Void ) {
        service.get(account: account) { (appKey: Result<String, KeyChainError>) in
            switch appKey {
            case let .success(key):
                self.setAppKey(key: key)
                
                guard let storageKey = self.storage.key else { return }
                completion(.success(storageKey))
            case let .failure(error):
                completion(.failure(.unexpectedPasswordData))
            }
        }
    }
    
    func saveAppKey() {
        service.save(account: account, key: "78491d0cbb6373d38514d3f70cc80674")
    }
    
    func setAppKey(key: String) {
        storage.key = key
    }
}
