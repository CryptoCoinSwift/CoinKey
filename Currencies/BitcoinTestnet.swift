//
//  Bitcoin.swift
//  CryptoCoin
//
//  Created by Sjors Provoost on 05-08-14.
//

public class BitcoinTestnet : CoinKey {
    // Generates a random Bitcoin keypair
    public init() {
        super.init(privateKeyPrefix: 0xef, publicKeyPrefix: 0x6f)
    }
}