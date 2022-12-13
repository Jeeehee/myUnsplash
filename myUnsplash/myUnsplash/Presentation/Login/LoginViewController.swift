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
import KakaoSDKCommon

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel?
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "kakao_login"), for: .normal)
        return button
    }()

    init(viewModel: LoginViewModel?) {
        super.init(nibName: nil, bundle: nil)
        
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    deinit {
        fatalError("Deinit: \(#fileID)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bind()
        layout()
    }
    
    private func bind() {
        loginButton.addAction(.init(handler: { [weak self] _ in
            self?.viewModel?.action.didTapLoginButton()
        }), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

