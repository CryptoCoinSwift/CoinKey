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
    
    func testHash160() {
        var messageBytes: [UInt8] = [0x60, 0x0f, 0xfe, 0x42, 0x2b, 0x4e, 0x00, 0x73, 0x1a, 0x59, 0x55, 0x7a, 0x5c, 0xca, 0x46, 0xcc, 0x18, 0x39, 0x44, 0x19, 0x10, 0x06, 0x32, 0x4a, 0x44, 0x7b, 0xdb, 0x2d, 0x98, 0xd4, 0xb4, 0x08]
        
        var digestBytes: [UInt8] = [0x01,0x09,0x66,0x77,0x60,0x06,0x95,0x3d,0x55,0x67,0x43,0x9e,0x5e,0x39,0xf8,0x6a,0x0d,0x27,0x3b,0xee]

        let message = NSData(bytes: &messageBytes, length: messageBytes.count)
        let digest = NSData(bytes: &digestBytes, length: digestBytes.count)
        
        // digest = RIPEMD160(message)
        
        var script = TransactionScript([digest, message, Op.Hash160, Op.Equal])
        
        XCTAssertTrue(script.evaluate(), "Script should pass")
    }


}
