//
//  KeyChainPropertyWrapper.swift
//  twoWeeksChallenge
//
//  Created by Kentaro Mihara on 2022/07/19.
//

import SwiftUI

// MARK: Custom Wrapper for KeyChain
// for easy to use

@propertyWrapper
struct KeyChain: DynamicProperty{
    
    @State var data: Data?
    
    var wrappedValue: Data?{
        get{KeyChainHelper.standard.read(key: key, account: account)}
        nonmutating set{
            guard let newData = newValue else{
                // if we set data to nil
                // simply delete the keychain data
                data = nil
                KeyChainHelper.standard.delete(key: key, account: account)
                return
            }
            
            // Updating or Setting Keychain data
            KeyChainHelper.standard.save(data: newData, key: key, account: account)
            
            
            // Updating Data
            data = newValue
        }
    }
    
    var key: String
    var account: String
    
    init(key: String, account: String){
        self.key = key
        self.account = account
        
        // Setting Initial State Keychain Data
        _data = State(wrappedValue: KeyChainHelper.standard.read(key: key, account: account))
    }
    
}

