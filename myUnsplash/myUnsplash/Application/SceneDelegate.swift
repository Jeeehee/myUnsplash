//
//  SceneDelegate.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: BaseCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationCotroller = UINavigationController()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationCotroller
        
        coordinator = AppCoordinator(navigationController: navigationCotroller)
        coordinator?.start()
        
        window?.makeKeyAndVisible()
    }
}

