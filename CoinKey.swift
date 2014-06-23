//
//  CoinKey.swift
//  BitB
//
//  Created by Sjors Provoost on 23-06-14.
//

import Foundation

class CoinKey {
    let privateKey: Int // Will need to be bigger...
    
    init(privateKey: Int) {
        self.privateKey = privateKey
    }
    
    class func createRandom () -> CoinKey {
        return CoinKey(privateKey: 1)
    }
    
}