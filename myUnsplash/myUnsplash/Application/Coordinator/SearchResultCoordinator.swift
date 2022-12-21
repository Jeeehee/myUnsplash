//
//  SearchResultCoordinator.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/21.
//

import UIKit

final class SearchResultCoordinator: BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let searchResultViewController = SearchResultViewController()
        navigationController.pushViewController(searchResultViewController, animated: true)
        navigationController.isNavigationBarHidden = true
    }
}
