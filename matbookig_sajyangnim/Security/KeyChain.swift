//
//  KeyChain.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import Foundation
import Security

class KeyChain {
    class func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: (token).data(using: .utf8, allowLossyConversion: false) as Any
        ]
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    class func read(key: String) -> String? {
        let query:NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loadingm status code = \(status)")
            return nil
        }
    }
    
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status==noErr, "failed to delete the value, status code = \(status)")
    }
}
