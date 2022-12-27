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
    var isUpdate: Observable<Bool>  { get }
    var results: Observable<[Photo]>?  { get }
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
    
    var isUpdate = Observable<Bool>(nil)
    var results: Observable<[Photo]>?
    var photos = Photos()
    
    init() {
        fatchData()
    }
    
    func fatchData() {
        useCase
            .start([Photo].self, url: NetworkTarget.list(page: 1).url, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                self?.results = Observable(data)
                self?.mapData()
            case .failure(let failure):
                print("Error")
            }
        }
    }
    
    func mapData() {
        guard let result = results?.value else { return }
        self.photos.append(result)
        self.isUpdate = Observable(true)
    }
}
