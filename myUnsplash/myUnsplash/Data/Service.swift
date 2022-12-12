//
//  Service.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/11.
//

import Foundation

final class Service {
    func save(account: String, key: String) {
        guard let data = key.data(using: String.Encoding.utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
      
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else { return }
        guard status == errSecSuccess else { return }
    }

    func get(account: String, completion: @escaping (Result<String, KeyChainError>) -> Void ) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { completion(.failure(.noPassword)); return }
        guard status == errSecSuccess else { completion(.failure(.unknown(status))); return }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data,
              let password = String(data: data, encoding: .utf8) else { completion(.failure(.unexpectedPasswordData)); return }
        
        completion(.success(password))
    }
    
    func delete(account: String, key: String) {
        guard let data = key.data(using: String.Encoding.utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { return }
    }
}
