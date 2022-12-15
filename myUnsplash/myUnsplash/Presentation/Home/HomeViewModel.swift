//
//  HomeViewModel.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

protocol HomeAction {
    func didTapLoginButton()
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
}
