//
//  CoinKey.swift
//  Crypto Coin Swift
//
//  Created by Sjors Provoost on 23-06-14.
//

// Assuming all cryptocurrencies use Secp256k1. Move domain selection to subclass if that's not the case.

import ECurveMac
import UInt256Mac

class CoinKey : ECKey {
    let prefix: UInt8
    
    init(_ privateKeyHex: String, prefix: UInt8) {
        self.prefix = prefix
        super.init(UInt256(hexStringValue: privateKeyHex), ECurve(domain: .Secp256k1))
    }
    
    var prefixString: String {
        let prefixHexString = String(NSString(format:"%2X", prefix))
    
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
    
    var wif : String {
       let extendedKey = prefixString + privateKeyHexString
        
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
    
    var publicAddress : String {
        return "Wrong" // 
    }
    

}