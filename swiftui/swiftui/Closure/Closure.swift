//
//  Closure.swift
//  swiftui
//
//  Created by Abdur Rahim on 15/09/24.
//

import Foundation

//Capturing Self in Closures
class CaptureClosure {
    var value = 10
    func doSomething() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            [weak self] in
            guard let self = self else { return }
            print(self.value)
        }
    }
}

struct Closure {
    //Basic closure Unnamed Closure or inline closure
    let sumClosure = { (a:Int, b:Int) -> Int in
        return a+b
    }
    func inlineClosureCall() {
        let result = sumClosure(3, 4)
        print(result)
    }
    
    //Trailing Closure
    func performOperation(closure:() -> Void) {
        closure()
    }
    func trailingClosureCall() {
        performOperation {
            print("This is a trailing closure")
        }
    }
    
    //Closure with Parameters and return value
    let multiplyClosure = { (a:Int, b: Int) -> Int in
      return a*b
    }
    func closureParamWithReturnValueCall() {
        let result = multiplyClosure(5, 4)
        print(result)
    }
    
    //Closure Capturing Values
    func makeIncrementer(incrementerAccount: Int) -> () -> Int {
        var total = 0
        let incrementer: () -> Int = {
            total += incrementerAccount
            return total
        }
        return incrementer
    }
    func closureWithCapturingCall() {
        let incrementByTwo = makeIncrementer(incrementerAccount: 2)
        print(incrementByTwo())
        print(incrementByTwo())
    }
    
    //Escaping closure
    func performAsyncTask(completion: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion()
        }
    }
    func escapingClosureCall() {
        performAsyncTask {
            print("Async task completed")
        }
    }
    
    //Autoclosures
    func printMessage(_ message: @autoclosure() -> String) {
        print("Message \(message())")
    }
    func autoClosureCall() {
        printMessage("Hello World")
    }
    
    //Capturing self closure
    func captureClosureCall() {
        let obj = CaptureClosure()
        obj.doSomething()
    }
    
    //closure short-hand argument
    func closureShortHandCall() {
        let numbers = [1, 2, 3, 4, 5, 6]
        let doublenumbers = numbers.map { $0 * 2 }
        print(doublenumbers)
    }
    
    //Function Closures
    func addTwonumbers(a:Int, b: Int) -> Int {
        return a + b
    }
    func addTwoNumbersCall() {
        let addclosure: (Int, Int) -> Int = addTwonumbers
        print(addclosure(5, 7))
    }
}
