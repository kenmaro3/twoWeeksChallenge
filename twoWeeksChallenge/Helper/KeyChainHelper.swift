//
//  KeyChainHelper.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI

// MARK: KeyChain helper class
class KeyChainHelper{
    
    // to access class data
    static let standard = KeyChainHelper()
    
    // MARK: Saving Keychain Values
    func save(data: Data, key: String, account: String){
        // Creating query
        let query = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        
        // Adding data to keychain
        let status = SecItemAdd(query, nil)
        
        // Checking for status
        switch status{
            // success
        case errSecSuccess: print("success")
            // Updating data
        case errSecDuplicateItem:
            let query = [
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            // Update Field
            let updateAttr = [kSecValueData: data] as CFDictionary
            
            SecItemUpdate(query, updateAttr)
            
            // other wise error
        default: print("error \(status)")
        }
        
        
    }
    
    
    // MARK: Reading Keychaing data
    func read(key: String, account: String)->Data?{
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        // To Copy the Data
        var resultData: AnyObject?
        SecItemCopyMatching(query, &resultData)
        
        return (resultData as? Data)
        
    }
    
    
    // MARK: Deleting Keychaing Data
    func delete(key: String, account: String){
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    
}
