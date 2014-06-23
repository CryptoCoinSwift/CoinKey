//
//  CoinKey.swift
//  BitB
//
//  Created by Sjors Provoost on 23-06-14.
//

import Foundation

struct CoinKey {
    let privateKey: UInt32 // Will need to be bigger...
    
    let publicAddress : String
    
    var privateKeyHexString: String {
        return NSString(format:"%2X", self.privateKey) as String
    }
    
    init(privateKey: UInt32) {
        self.privateKey = privateKey
        self.publicAddress = "Wrong"
    }
    
    static func createRandom () -> CoinKey {
        return CoinKey(privateKey: arc4random())
    }
    
}