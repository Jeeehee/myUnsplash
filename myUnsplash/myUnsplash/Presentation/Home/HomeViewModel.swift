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
    var photos: Photos { get }
}

protocol HomeViewModelProtocol: HomeAction, HomeState {
    var action: HomeAction { get }
    var state: HomeState { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let useCase = UnsplashUseCase(repository: UnsplashRepositoryImpl())
    
    var action: HomeAction { self }
    var state: HomeState { self }
    
    var photos = Photos()

    init() {
        bind()
    }
    
    func bind() {
        useCase
            .start([Photo].self, url: NetworkTarget.list(page: 1).url, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                self?.photos.append(data)
                
            case .failure(let failure):
                print("Error")
            }
        }
    }
}
