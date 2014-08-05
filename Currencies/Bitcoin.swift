//
//  Bitcoin.swift
//  CryptoCoin
//
//  Created by Sjors Provoost on 05-08-14.
//

public class Bitcoin : CoinKey {
    // Generates a random Bitcoin keypair
    public init() {
        super.init(privateKeyPrefix: 0x80, publicKeyPrefix: 0x00)
    }
}