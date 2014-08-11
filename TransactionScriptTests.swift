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

    func testDup() {
        var script = TransactionScript([2, Op.Dup, Op.Equal])
        
        XCTAssertTrue(script.evaluate(), "Script should pass")
        
    }
    
    func testNSData() {
        var bytes: [UInt8] = [0x20, 0x20]
        let data = NSData(bytes: &bytes, length: 2)
        
        var script = TransactionScript([data, Op.Dup, Op.Equal])
        
        XCTAssertTrue(script.evaluate(), "Script should pass")
    }


}
