//
//  TransactionScriptTests.swift
//  CryptoCoin
//
//  Created by Sjors Provoost on 11-08-14.
//

import XCTest
import CryptoCoin
import ECurve
import UInt256

class TransactionScriptTests: XCTestCase {
    
    let curve = ECurve(domain: .Secp256k1)
    
    var publicKeyPoint: ECPoint? = nil

    override func setUp() {
        super.setUp()
        let publicKeyX = FFInt("50863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B2352", curve.field)
        let publicKeyY = FFInt("2CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6", curve.field)
        
        publicKeyPoint = ECPoint(x: publicKeyX, y: publicKeyY, curve: curve)
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
    
    func testCheckSig() {

        let ecKey = ECKey(publicKeyPoint: publicKeyPoint!)
        
        let digest: UInt256 = 0x32 // Normally this is the transaction hash
        
        var signatureBytes: [UInt8] = [0x30, 0x45, 0x02, 0x20,
            0x61, 0xcc, 0xae, 0x67, 0x5a, 0xe0, 0x9a, 0xf5, 0xd3, 0xb1, 0x83, 0x1d, 0x16, 0x04, 0xb6, 0xa5, 0x78, 0xdc, 0xbb, 0x34, 0x93, 0xdc, 0x04, 0xa7, 0x07, 0x7e, 0x4b, 0xd1, 0x94, 0xcb, 0xbb, 0x6c,
            0x02, 0x21,
            0x00, 0xae, 0x1d, 0xa0, 0xca, 0x5d, 0x73, 0xfe, 0xe8, 0x58, 0x85, 0xf3, 0x1b, 0xef, 0x58, 0x94, 0xf2, 0xd2, 0xcb, 0x3e, 0x83, 0x92, 0x16, 0x3e, 0x20, 0x12, 0x73, 0x68, 0xe3, 0x35, 0x34, 0xb5, 0x3d]
        
        let signature = NSData(bytes: &signatureBytes, length: signatureBytes.count)
        
        // public key, signature, check signature
        
        var script = TransactionScript([signature, publicKeyPoint!.toData, Op.CheckSig])

        XCTAssertTrue(script.evaluate(), "Script should pass")
    }


}
