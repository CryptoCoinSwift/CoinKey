//
//  CoinKeyTests.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 23-06-14.
//

import XCTest
import CryptoCoinMac

class CoinKeyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWIF() {
        let coinkey = CoinKey("0C28FCA386C7A227600B2FE50B7CAE11EC86D3BF1FBE471BE89827E19D72AA1D", privateKeyPrefix: 0x80, publicKeyPrefix: 0x00, skipPublicKeyGeneration: true)
        
        let wif = "5HueCGU8rMjxEXxiPuD5BDku4MkFqeZyd4dZ1jvhTVqvbTLvyTJ"
        
        let result = coinkey.wif
        
        XCTAssertEqual(result, wif, result)
        
    }
        
    func testPublicAddress() {
        let coinKey = CoinKey("1184cd2cdd640ca42cfc3a091c51d549b2f016d454b2774019c2b2d2e08529fd", "0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6", privateKeyPrefix: 0x80, publicKeyPrefix: 0x00)
        
        let result = coinKey.publicAddress
        
        XCTAssertEqual(result, "16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM","")
    }
    
    
}
