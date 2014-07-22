//
//  CoinKey.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 23-06-14.
//

// Assuming all cryptocurrencies use Secp256k1. Move domain selection to subclass if that's not the case.

import ECurveMac
import UInt256Mac
import RIPEMDmac
import SHA256

public class CoinKey : ECKey {
    let privateKeyPrefix: UInt8
    let publicKeyPrefix: UInt8

    
    public init(_ privateKeyHex: String, privateKeyPrefix: UInt8, publicKeyPrefix: UInt8, skipPublicKeyGeneration: Bool = true) {
        self.privateKeyPrefix = privateKeyPrefix
        self.publicKeyPrefix = publicKeyPrefix
        super.init(UInt256(hexStringValue: privateKeyHex), ECurve(domain: .Secp256k1), skipPublicKeyGeneration: skipPublicKeyGeneration)
    }
    
    public init(_ privateKeyHex: String, _ publicKeyHex: String, privateKeyPrefix: UInt8, publicKeyPrefix: UInt8) {
        self.privateKeyPrefix = privateKeyPrefix
        self.publicKeyPrefix = publicKeyPrefix
        let point = ECKey.pointFromHex(publicKeyHex, ECurve(domain: .Secp256k1))
        super.init(privateKey: UInt256(hexStringValue: privateKeyHex), publicKeyPoint: point)
    }

    // Generates a random Bitcoin keypair
    public init() {
        var key = ECKey.createRandom(ECurve(domain: .Secp256k1))
        
        self.privateKeyPrefix = 0x80
        self.publicKeyPrefix = 0x00

        super.init(privateKey: key.privateKey, publicKeyPoint: key.publicKeyPoint)
    }

    
 
    
    public var privateKeyPrefixString: String {
        let prefixHexString = String(NSString(format:"%2X", privateKeyPrefix))
    
        switch countElements(prefixHexString) {
        case 0:
            return "00"
        case 1:
            return "0" + prefixHexString
        case 2:
            return prefixHexString
        default:
            assert(false, "Invalid prefix")
            return "00"
        }
    }
    
    public var wif : String {
       let extendedKey = privateKeyPrefixString + privateKeyHexString
        
        let hash1: NSData = SHA256.hexStringDigest(extendedKey)
        
        let hash2: String = SHA256.hexStringDigest(hash1)
        
        var checksum: String = ""
        for char in hash2 {
            checksum += char
            if countElements(checksum) == 8 { break; }
        }
        
        let keyWithChecksum = extendedKey + checksum
        
        return BaseConverter.convertBase(keyWithChecksum, fromBase: 16, toBase: 58)
    }
    
    public var publicAddress : String {
        let sha256: NSData = SHA256.hexStringDigest(self.publicKeyHexString)
        
        let ripemd: NSData = RIPEMD.digest(sha256)
        
        var extenedRipemd = NSMutableData()
            
        let versionByte: [UInt8] = [publicKeyPrefix]
        extenedRipemd.appendBytes(versionByte, length: 1)
        extenedRipemd.appendBytes(ripemd.bytes, length: ripemd.length)
            
        let doubleSHA: String = SHA256.hexStringDigest(SHA256.digest(extenedRipemd))
        
        let checksum: String = (doubleSHA as NSString).substringWithRange(NSRange(location: 0, length: 8))

        let hexAddress = extenedRipemd.toHexString() + checksum

        let  base58 = BaseConverter.convertBase(hexAddress, fromBase: 16, toBase: 58)
            
            
        var leadingOnes: String = ""
        for var i=0; i < countElements(hexAddress); i += 2 {
            let digit: String = (hexAddress as NSString).substringWithRange(NSRange(location: i, length: 2))
            
            if digit == "00" {
                leadingOnes += "1"
            } else {
                break;
            }
        }
        
        return leadingOnes + base58
    }
    

}