//
//  CoinKeyTests.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 23-06-14.
//

import XCTest
import CryptoCoin

class CoinKeyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testPublicAddress() {
        let coinKey = CoinKey(privateKey: 1); // 1184cd2cdd640ca42cfc3a091c51d549b2f016d454b2774019c2b2d2e08529fd
        
        XCTAssertEqual(coinKey.publicAddress, "16UjcYNBG9GTK4uq2f7yYEbuifqCzoLMGS", "Public address matching private key");
        
    }
    
    
}
