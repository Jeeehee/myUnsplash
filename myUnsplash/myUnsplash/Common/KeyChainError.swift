//
//  KeyChainError.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/13.
//

import Foundation

enum KeyChainError: Error {
    case failedSave
    case duplicationEntry
    case noPassword
    case unexpectedPasswordData
    case unknown(OSStatus)
}
