//
//  UseCase.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/11.
//

import Foundation

final class UseCase {
    private let kakaoRepository: KakaoLoginRepository
    
    init(kakaoRepository: KakaoLoginRepository) {
        self.kakaoRepository = kakaoRepository
    }
    
    func start(completion: @escaping (Result<String, KeyChainError>) -> Void) {
        kakaoRepository.getAppKey { (appKey: Result<String, KeyChainError>) in
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
