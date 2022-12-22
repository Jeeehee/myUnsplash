//
//  SearchViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/21.
//

import Foundation

protocol SearchAction {
    func isSearchBarTextEditig(_ query: String)
    func getSearchResult()
}

protocol SearchState {
    var query: Observable<String> { get }
}

protocol SearchViewModelProtocol: SearchAction, SearchState {
    var action: SearchAction { get }
    var state: SearchState { get }
}

final class SearchViewModel: SearchViewModelProtocol {
    private let navigator: Navigator?
    private let useCase = UnsplashUseCase(repository: UnsplashRepositoryImpl())
    
    var action: SearchAction { self }
    var state: SearchState { self }
    
    var photos = Photos()
    var query = Observable("")
    var qureyString = ""
    
    init(navigator: Navigator?) {
        self.navigator = navigator
    }
    
    func getSearchResult() {
        self.query
            .value
            .map { self.qureyString += String($0) }
        
        useCase
            .start(Photo.self, url: NetworkTarget.search(query: "search", page: 1).url, method: .get) { result in
            switch result {
            case .success(let data):
                self.photos.append(data)
                
            case .failure(let failure):
                print("Error")
            }
        }
    }
    
    func isSearchBarTextEditig(_ query: String) {
//        navigator?.presentNextViewController()
        self.query = Observable(query)
    }
    
}
