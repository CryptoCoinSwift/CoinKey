//
//  BitBTests.swift
//  BitBTests
//
//  Created by Sjors Provoost on 23-06-14.
//

import XCTest
import CryptoCoinSwift

class CoinKeyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithPrivateKey() {
        let coinKey = CoinKey(privateKey: 1)
        
        XCTAssertEqual(coinKey.privateKey , 1, "Private key correct");
    }
    
    func testCreateRandom() {
        let coinKey1 = CoinKey.createRandom();
        let coinKey2 = CoinKey.createRandom();
        
        XCTAssertNotEqual(coinKey1.privateKey, coinKey2.privateKey, "Two random private keys can't be equal");
        
    }
    
    
}
