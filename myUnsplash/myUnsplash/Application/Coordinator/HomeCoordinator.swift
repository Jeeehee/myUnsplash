//
//  HomeCoordinator.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let homeViewController = HomeViewController()
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
