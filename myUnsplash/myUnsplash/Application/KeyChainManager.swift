//
//  KeyChainManager.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/10.
//

import Foundation

final class AppKey {
    static let shared = AppKey()

    var key: String?
    
    private init() {
        
    }
}
//
//struct KakaoLoginManager {
//    private let account = "Kakao_Login"
//    private let keyChainManager = KeyChainManager()
//    private let appKey = AppKey.shared
//
//    private func saveAppkey() {
//        keyChainManager.save(account: account, key: "78491d0cbb6373d38514d3f70cc80674")
//    }
//
//    func getAppKey() {
//        guard let key = keyChainManager.get(account: account) else { return }
//        appKey.key = key
//    }
//}

enum KeyChainError: Error {
    case failedSave
    case duplicationEntry
    case noPassword
    case unexpectedPasswordData
    case unknown(OSStatus)
}

final class KeyChainManager {
    private let appKey = AppKey.shared
    
    func save(account: String, key: String) {
        guard let data = key.data(using: String.Encoding.utf8) else { return } // Data타입으로 Key 변환
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        // KeyChainManager.save(account: "어카운트", key: "Key") 호출 시
        // ["class": genp, "acct": "어카운트", "v_Data": 3 bytes] 와 같이 저장
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else { return }
        guard status == errSecSuccess else { return }
    }

    func get(account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef? // typealias CFTypeRef = AnyObject
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return }
        guard status == errSecSuccess else { return }
        
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data,
              let password = String(data: data, encoding: .utf8) else { return }
        
        appKey.key = password
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
