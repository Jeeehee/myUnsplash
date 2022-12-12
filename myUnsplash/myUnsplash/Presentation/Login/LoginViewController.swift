//
//  LoginViewController.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
        addAction()
    }
    
    private func layout() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func addAction() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    _ = oauthToken
                }
            }
        }
    }


}

