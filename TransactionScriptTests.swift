//
//  TransactionScriptTests.swift
//  CryptoCoin
//
//  Created by Sjors Provoost on 11-08-14.
//

import XCTest
import CryptoCoin

class TransactionScriptTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAdd() {
        var script = TransactionScript([2, 3, Op.Add, 5, Op.Equal])
       
        XCTAssertTrue(script.evaluate(), "Script should pass")
        
        script = TransactionScript([2, 3, Op.Add, 6, Op.Equal])
        
        XCTAssertFalse (script.evaluate(), "Script should not pass")

    }



}
