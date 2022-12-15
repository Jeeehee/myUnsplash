//
//  HomeViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

protocol HomeAction {

}

protocol HomeState {
    
}

protocol HomeViewModelProtocol: HomeAction, HomeState {
    var action: HomeAction { get }
    var state: HomeState { get }
}

struct HomeViewModel: HomeViewModelProtocol {
    var action: HomeAction { self }
    var state: HomeState { self }
    
    private let useCase = UnsplashUseCase(repository: UnsplashRepositoryImpl())
    
    init() {
        bind()
    }
    
    let photos = Photos()
    
    func bind() {
        useCase.start(Photo.self, url: NetworkTarget.list.url, method: .get) { result in
            guard result != nil else { return }
            
        }
    }
}
