//
//  Repository.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/15.
//

import Foundation

protocol Repository {
    func getKey(account: String, completion: @escaping (Result<String, KeyChainError>) -> Void)
    func saveKey(account: String, key: String)
    func setKey(account: String, key: String)
}
