//
//  SearchViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/21.
//

import Foundation

protocol SearchAction {
    func isSearchBarTextEditig(_ query: String)
    func getSearchResult(completion: @escaping ([Photo]?) -> Void)
}

protocol SearchState {
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
    
    var qureyString: String?
    
    init(navigator: Navigator?) {
        self.navigator = navigator
    }
    
    func getSearchResult(completion: @escaping ([Photo]?) -> Void) {
        guard let qureyString = qureyString else { return }
        
        useCase
            .start(Results.self, url: NetworkTarget.search(query: qureyString, page: 1).url, method: .get) { result in
            switch result {
            case .success(let data):
                completion(data.results)
                
            case .failure(let failure):
                print("Error")
            }
        }
    }
    
    func isSearchBarTextEditig(_ query: String) {
        self.qureyString = query
    }
}
