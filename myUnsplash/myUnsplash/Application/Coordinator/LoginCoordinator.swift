//
//  LoginCoordinator.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let loginViewController = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
