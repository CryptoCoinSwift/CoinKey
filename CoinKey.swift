//
//  CoinKey.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 23-06-14.
//

import Foundation

struct CoinKey {
    let privateKey: UInt256
    
    let publicAddress : String
    
    var privateKeyHexString: String {
        return privateKey.toHexString
    }
    
    init(privateKey: UInt256) {
        self.privateKey = privateKey
        self.publicAddress = "Wrong"
    }
    
    static func createRandom () -> CoinKey {
        return CoinKey(privateKey: UInt256(mostSignificantOf8UInt32First: [arc4random_uniform(UInt32.max), arc4random_uniform(UInt32.max),arc4random_uniform(UInt32.max),arc4random_uniform(UInt32.max),arc4random_uniform(UInt32.max),arc4random_uniform(UInt32.max),arc4random_uniform(UInt32.max),arc4random_uniform(UInt32.max)]))
    }
    
}