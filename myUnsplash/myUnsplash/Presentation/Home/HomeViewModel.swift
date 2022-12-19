//
//  HomeViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

protocol HomeAction {
    var isLoading: Observable<Bool> { get }
}

protocol HomeState {
//    var loadData: Observable<[Photo]> { get }
}

protocol HomeViewModelProtocol: HomeAction, HomeState {
    var action: HomeAction { get }
    var state: HomeState { get }
}

struct HomeViewModel: HomeViewModelProtocol {

    var action: HomeAction { self }
    var state: HomeState { self }
    
    var isLoading = Observable(false)
    
    var photos = Photos()
    private let useCase = UnsplashUseCase(repository: UnsplashRepositoryImpl())
    
    init() {
        bind()
    }
    
    func bind() {
        useCase.start(Photo.self, url: NetworkTarget.list.url, method: .get) { result in
            isLoading.value = false
            
            switch result {
            case .success(let data):
                photos.append(data)
                
            case .failure(let failure):
                print("Error")
            }
        }
    }
}
