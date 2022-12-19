//
//  AppCoordinator.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    var childCoordinators = [BaseCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        `Type`.allCases.forEach {
            let coordinator = $0.coordinator
            coordinator.navigationController.tabBarItem = $0.tabBarItem
            
            addChild(coordinator)
            coordinator.start()
        }
        
        let tabBarController = createTabBarController()
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = .black
        tabBarController.tabBar.layer.masksToBounds = false
        tabBarController.tabBar.layer.cornerRadius = 50
        tabBarController.viewControllers = childCoordinators.compactMap { $0.navigationController }
        
        return tabBarController
    }
    
    private func showViewController(type viewController: `Type`) {
        let coordinator = viewController.coordinator
        addChild(coordinator)
        
        coordinator.start()
    }
}

extension AppCoordinator {
    enum `Type`: CaseIterable {
        case home, login
        
        var coordinator: BaseCoordinator {
            switch self {
            case .home: return HomeCoordinator()
            case .login: return LoginCoordinator()
            }
        }
        
        var tabBarItem: UITabBarItem {
            switch self {
            case .home: return UITabBarItem(
                title: "Home",
                image: .init(systemName: "house"),
                tag: 0
            )
                
            case .login: return UITabBarItem(
                title: "login",
                image: .init(systemName: "person"),
                tag: 1
            )
            }
        }
    }
}
