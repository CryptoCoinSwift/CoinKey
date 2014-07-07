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
        let coinkey = CoinKey("0C28FCA386C7A227600B2FE50B7CAE11EC86D3BF1FBE471BE89827E19D72AA1D", prefix: 0x80)
        
        let wif = "5HueCGU8rMjxEXxiPuD5BDku4MkFqeZyd4dZ1jvhTVqvbTLvyTJ"
        
        let result = coinkey.wif
        
        XCTAssertEqual(result, wif, result)
        
    }
        
    func testPublicAddress() {
        let coinKey = CoinKey("1184cd2cdd640ca42cfc3a091c51d549b2f016d454b2774019c2b2d2e08529fd", prefix:0x80)
        
//        XCTAssertEqual(coinKey.publicAddress, "16UjcYNBG9GTK4uq2f7yYEbuifqCzoLMGS", coinKey.publicAddress)
    }
    
    
}
