//
//  Script.swift
//  CryptoCoin
//
//  Created by Sjors Provoost on 11-08-14.
//

import Foundation
import RIPEMD
import ECurve
import UInt256

public protocol TransactionScriptItem {}
public protocol TransactionStackItem {}


extension Int : TransactionScriptItem, TransactionStackItem {}
extension Bool : TransactionStackItem {}
extension NSData : TransactionScriptItem, TransactionStackItem {}


public enum Op : TransactionScriptItem  {
    case Add
    case Equal
    case Dup
    case Hash160
    case CheckSig
}

public struct TransactionScript {

    struct Stack {
        var stack: [TransactionStackItem] = []

        mutating func popTwoIntegers () -> (Int , Int) {
            assert(stack.count >= 2, "Not enough stuff on the stack")
            let a = stack.removeLast()
            let b = stack.removeLast()
            
            assert(a is Int && b is Int, "Looking for two integer")
            
            return (a as Int, b as Int)
            
        }
        
        mutating func push (item: TransactionStackItem) {
            stack.append(item)
        }
        
        mutating func pop () -> (TransactionStackItem) {
            return stack.removeLast()
        }
        
        var top: TransactionStackItem {
            assert(stack.count >= 1, "Not enough stuff on the stack")

            return stack.first!
        }
        
        var count: Int {
            return stack.count
        }
    }
    
    let items: [TransactionScriptItem]
    
    public init (_ items: [TransactionScriptItem]) {
        self.items = items
    }
    
    public func evaluate() -> Bool {
        
        var stack = Stack()
        
        for item in items {
            if item is Int {
                stack.push(item as Int)
            } else if item is NSData {
                stack.push(item as NSData)
            } else if item is Op {
                switch item as Op {
                case .Add:
                    let (a,b) = stack.popTwoIntegers()
                     stack.push(a + b)
                case .Dup:
                    stack.push(stack.top)
                case .Equal:
                    let a = stack.pop()
                    let b = stack.pop()
                    
                    if a is Int && b is Int {
                        stack.push(a as Int == b as Int)

                    } else if a is NSData && b is NSData {
                        stack.push((a as NSData).isEqualToData(b as NSData))

                    } else {
                        assert(false, "Invalid script")
 
                    }
                case .Hash160:
                    let message = stack.pop()
                    
                    if message is NSData {
                        let digest: NSData = RIPEMD.digest(message as NSData)
                        stack.push(digest)
                    } else {
                        assert(false, "Invalid script")
                        return false
                    }

                case .CheckSig:
                    let pubKey = stack.pop()
                    let signature = stack.pop()
                    
                    if pubKey is NSData && signature is NSData {
                        let curve = ECurve(domain: .Secp256k1)
                        let P = curve.point(pubKey as NSData)
                        
                        let (r,s) = ECKey.importDer(signature as NSData)
                        
                        let digest: UInt256 = 0x32 // TODO: use transaction
                        
                        stack.push(ECKey.verifySignature(digest, r: r, s: s, publicKey: P!))
                    } else {
                        assert(false, "Invalid script")
                        return false
                    }
                    
                    

                    
                default:
                    assert(false, "Invalid script")
                }
            } else {
                assert(false, "Invalid script")
                return false
            }
        }
        
        if stack.count == 1 {
            let item = stack.pop()
            
            if item is Bool {
                return (item as Bool)
            }
        }
        
        return false
        
    }
    

}
