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

    struct Stack {
        var stack: [TransactionStackItem] = []

        mutating func popTwoIntegers () -> (Int, Int) {
            assert(stack.count >= 2, "Not enough stuff on the stack")
            let a = stack.removeLast()
            let b = stack.removeLast()
            
            assert(a is Int && b is Int, "Looking for two integer")
            
            return (a as Int, b as Int)
            
        }
        
        mutating func push (item: TransactionStackItem) {
            stack.append(item)
        }
        
        mutating func pop () -> (item: TransactionStackItem) {
            return stack.removeLast()
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
            } else if item is Op {
                switch item as Op {
                case .Add:
                    let (a,b) = stack.popTwoIntegers()
                     stack.push(a + b)
                case .Equal:
                    let (a,b) = stack.popTwoIntegers()
                    stack.push(a == b)
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
