//
//  HomeViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

protocol HomeAction {
    var isLoading: Observable<Bool> { get }
    func isSearchBarTextEditig()
}

protocol HomeState {
//    var searchBarTextEditig: Observable<Bool>  { get }
}

protocol HomeViewModelProtocol: HomeAction, HomeState {
    var action: HomeAction { get }
    var state: HomeState { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let navigator: Navigator?
    private let useCase = UnsplashUseCase(repository: UnsplashRepositoryImpl())
    
    var action: HomeAction { self }
    var state: HomeState { self }
    var photos = Photos()
    
    var isLoading = Observable(false)

    init(navigator: Navigator?) {
        self.navigator = navigator
        
        bind()
    }
    
    func bind() {
        useCase
            .start(Photo.self, url: NetworkTarget.list.url, method: .get) { result in
                self.isLoading.value = false
            
            switch result {
            case .success(let data):
                self.photos.append(data)
                
            case .failure(let failure):
                print("Error")
            }
        }
        
    }
    
    func isSearchBarTextEditig() {
        navigator?.presentNextViewController()
    }
}
