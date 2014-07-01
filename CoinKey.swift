//
//  CoinKey.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 23-06-14.
//

// Assuming all cryptocurrencies use Secp256k1. Move domain selection to subclass if that's not the case.

import ECurve
import UInt256

class CoinKey : ECKey {
    init(_ privateKeyHex: String) {
        super.init(UInt256(hexStringValue: privateKeyHex), ECurve(domain: .Secp256k1))
    }
    
    var publicAddress : String {
        return "Wrong" // 
    }
}