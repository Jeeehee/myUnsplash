//
//  Account.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

enum Account {
    case kakaoLogin
    case unsplash
    
    var name: String {
        switch self {
        case .kakaoLogin: return "Kakao_Login"
        case .unsplash: return "Unsplash"
        }
    }
}
