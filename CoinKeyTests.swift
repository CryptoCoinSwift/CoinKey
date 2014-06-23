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
    
    func testExample() {
        // This is an example of a functional test case.
        let coinKey = CoinKey()
        
        coinKey.privateKey = 1;
        
        if let pK = coinKey.privateKey {
            XCTAssertEqual(pK , 1, "Private key correct");

        } else {
            XCTFail("Pimary key not set");
        }
        
        
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
