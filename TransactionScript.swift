//
//  Script.swift
//  CryptoCoin
//
//  Created by Sjors Provoost on 11-08-14.
//

public protocol TransactionScriptItem {}
public protocol TransactionStackItem {}


extension Int : TransactionScriptItem, TransactionStackItem {}
extension Bool : TransactionStackItem {}


public enum Op : TransactionScriptItem  {
    case Add
    case Equal
}

public struct TransactionScript {

    
    let items: [TransactionScriptItem]
    
    public init (_ items: [TransactionScriptItem]) {
        self.items = items
    }
    
    public func evaluate() -> Bool {
        var stack: [TransactionStackItem] = []
        
        for item in items {
            if item is Int {
                stack.append(item as Int)
            } else if item is Op {
                switch item as Op {
                case .Add:
                    assert(stack.count >= 2, "Not enough stuff on the stack to add")
                    let a = stack.removeLast()
                    let b = stack.removeLast()
                    
                    assert(a is Int && b is Int, "Can only add integers")
                    
                    stack.append((a as Int) + (b as Int))
                case .Equal:
                    assert(stack.count >= 2, "Not enough stuff on the stack to compare")
                    let a = stack.removeLast()
                    let b = stack.removeLast()
                    
                    assert(a is Int && b is Int, "Can only compare integers")
                    
                    stack.append((a as Int) == (b as Int))
                default:
                    assert(false, "Invalid script")
                }
            } else {
                assert(false, "Invalid script")
                return false
            }
        }
        
        if stack.count == 1 {
            if stack.first! is Bool {
                return (stack.first! as Bool)
            }
        }
        
        return false
        
    }
}
