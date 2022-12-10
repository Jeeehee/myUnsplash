//
//  KeyChainManager.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/10.
//

import Foundation

enum KeyChainError: Error {
    case duplicationEntry
    case unknown(OSStatus)
}

final class KeyChainManager {
    static func save(service: String, account: String, data: String) throws {
        guard let data = data.data(using: String.Encoding.utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else { throw KeyChainError.duplicationEntry }
        guard status == errSecSuccess else { throw KeyChainError.unknown(status) }
    }
    
    static func get(service: String, account: String) throws -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else { throw KeyChainError.unknown(status) }
        
        return result as? Data
    }
}
