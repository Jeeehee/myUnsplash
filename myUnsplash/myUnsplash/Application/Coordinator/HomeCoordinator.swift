//
//  HomeCoordinator.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit
//
//final class HomeCoordinator: BaseCoordinator, Navigator {
//    var presentNextViewController: () -> Void
//
//    var childCoordinators: [BaseCoordinator] = []
//    var navigationController: UINavigationController
//
//    init(navigationController: UINavigationController = .init()) {
//        self.navigationController = navigationController
//
//        self.presentNextViewController = { [weak navigationController] in
//            let searchResultViewController = SearchResultViewController()
//            navigationController?.pushViewController(searchResultViewController, animated: true)
//            navigationController?.isNavigationBarHidden = false
//        }
//    }
//
//    func start() {
//        let viewModel = HomeViewModel(navigator: self)
//        let homeViewController = HomeViewController(viewModel: viewModel)
//        navigationController.pushViewController(homeViewController, animated: true)
//        navigationController.isNavigationBarHidden = true
//    }
//}



final class HomeCoordinator: BaseCoordinator, Navigator {
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    var presentNextViewController: () -> Void = {}
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let searchViewModel = SearchViewModel(navigator: self)
        let homeViewController = HomeViewController(viewModel: viewModel, searchViewModel: searchViewModel)
        navigationController.pushViewController(homeViewController, animated: true)
        navigationController.isNavigationBarHidden = true
    }
}
