//
//  LoginViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/12.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKUser

protocol LoginAction {
    func didTapLoginButton()
}

protocol LoginState {
    
}

protocol LoginViewModelProtocol: LoginAction, LoginState {
    var action: LoginAction { get }
    var state: LoginState { get }
}

struct LoginViewModel: LoginViewModelProtocol {
    private let useCase = UseCase(repository: Repository())
    
    var action: LoginAction { self }
    var state: LoginState { self }
    
    func didTapLoginButton() {
        useCase.start(with: Account.kakaoLogin) { (appKey: Result<String, KeyChainError>) in
            switch appKey {
            case let .success(key):
                KakaoSDK.initSDK(appKey: key)
                checkKakaoTalk()
                return
            case let .failure(error):
                fatalError("\(error)")
            }
        }
    }
    
    private func checkKakaoTalk() {
        guard UserApi.isKakaoTalkLoginAvailable() else { return }
        
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            guard error == nil else { return }
//            let token = oauthToken
        }
    }
}

