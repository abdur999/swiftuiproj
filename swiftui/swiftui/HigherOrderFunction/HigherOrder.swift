//
//  HigherOrder.swift
//  swiftui
//
//  Created by Abdur Rahim on 12/09/24.
//

import Foundation

struct HigherOrder {
    
    func mreduce() {
        let numbers = [1, 2, 3, 4, 5]
        let sum = numbers.reduce(0) { $0 + $1 }
        print(sum)  // Output: 15
    }

    func mmap() {
        let numbers = [1, 2, 3, 4, 5]
        let doubledNumbers = numbers.map { $0 * 2 }
        print(doubledNumbers)  // Output: [2, 4, 6, 8, 10]
    }
    func mfilter() {
        let numbers = [1, 2, 3, 4, 5]
        let evenNumbers = numbers.filter { $0 % 2 == 0 }
        print(evenNumbers)  // Output: [2, 4]
    }
    func mforeach() {
        let names = ["John", "Jane", "Jim"]
        names.forEach { print($0) }
    }
    func msorted() {
        let numbers = [3, 1, 4, 2, 5]
        let sortedNumbers = numbers.sorted { $0 < $1 }
        print(sortedNumbers)  // Output: [1, 2, 3, 4, 5]
    }
    func applyOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
        return operation(a, b)
    }
    func mapplyOperation() {
        let sum = applyOperation(10, 20, operation: { $0 + $1 })
        print(sum)  // Output: 30
    }

    func makeIncrementer(incrementAmount: Int) -> (Int) -> Int {
        return { num in
            return num + incrementAmount
        }
    }
    func mmakeIncrementer() {
        let incrementByFive = makeIncrementer(incrementAmount: 5)
        print(incrementByFive(10))  // Output: 15
    }
}

/*
 
 A higher-order function in Swift (and other functional programming languages) is a function that either:
 1. Takes one or more functions as arguments, or
 2. Returns a function as its result.
 Higher-order functions enable more expressive, flexible, and reusable code, often leading to more declarative and functional programming styles. They are commonly used in Swift for array transformations, event handling, and managing function composition.
 Examples of Higher-Order Functions in Swift:
 1. map(_:): Transforms each element of a collection.
 2. filter(_:): Returns a subset of a collection that meets a condition.
 3. reduce(_:_:_:): Combines all elements of a collection into a single value.
 Features of Higher-Order Functions
 * First-class functions: Functions in Swift are first-class citizens, which means you can pass them around as arguments, return them from other functions, and store them in variables.
 * Function Composition: You can build complex logic by combining simple functions, making your code modular and reusable.
 * Declarative style: Instead of specifying how to do something (imperative), you focus on what to do (declarative) using concise operations like mapping, filtering, etc.
 Common Higher-Order Functions in Swift:
 1. map(_:)
 map(_:) is used to transform each element in a collection using a closure. The result is a new array with the transformed values.
 swift
 Copy code
 let numbers = [1, 2, 3, 4, 5]
 let doubledNumbers = numbers.map { $0 * 2 }
 print(doubledNumbers)  // Output: [2, 4, 6, 8, 10]
 * The closure { $0 * 2 } is applied to each element in the numbers array.
 * map(_:) returns a new array with the results of the closure applied to each element.
 2. filter(_:)
 filter(_:) returns a new array containing only the elements that satisfy a condition.
 swift
 Copy code
 let numbers = [1, 2, 3, 4, 5]
 let evenNumbers = numbers.filter { $0 % 2 == 0 }
 print(evenNumbers)  // Output: [2, 4]
 * The closure { $0 % 2 == 0 } checks if each number is even.
 * Only the even numbers are included in the resulting array.
 3. reduce(_:_:_:)
 reduce(_:_:) is used to combine all the elements in a collection into a single value.
 swift
 Copy code
 let numbers = [1, 2, 3, 4, 5]
 let sum = numbers.reduce(0) { $0 + $1 }
 print(sum)  // Output: 15
 * The initial value is 0, and the closure { $0 + $1 } adds each element of the array to this value.
 * reduce(_:_:) accumulates a final result from the entire array.
 4. forEach(_:)
 forEach(_:) iterates over each element in a collection and performs an action on it.
 swift
 Copy code
 let names = ["John", "Jane", "Jim"]
 names.forEach { print($0) }
 * forEach prints each name in the array, iterating over the elements one by one.
 5. sorted(by:)
 sorted(by:) sorts a collection based on the closure’s comparison logic.
 swift
 Copy code
 let numbers = [3, 1, 4, 2, 5]
 let sortedNumbers = numbers.sorted { $0 < $1 }
 print(sortedNumbers)  // Output: [1, 2, 3, 4, 5]
 * The closure { $0 < $1 } ensures the array is sorted in ascending order.
 Custom Higher-Order Function Example:
 Here’s an example where a function takes another function as a parameter.
 swift
 Copy code
 func applyOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
     return operation(a, b)
 }

 let sum = applyOperation(10, 20, operation: { $0 + $1 })
 print(sum)  // Output: 30
 * applyOperation takes two integers and an operation (a closure) that defines how to combine them.
 * You can pass different closures to perform various operations (addition, multiplication, etc.).
 Returning a Function
 A higher-order function can also return a function.
 swift
 Copy code
 func makeIncrementer(incrementAmount: Int) -> (Int) -> Int {
     return { num in
         return num + incrementAmount
     }
 }

 let incrementByFive = makeIncrementer(incrementAmount: 5)
 print(incrementByFive(10))  // Output: 15
 * makeIncrementer returns a closure that increments a number by a specified amount (incrementAmount).
 * The resulting closure can be reused with different values.
 Use Cases of Higher-Order Functions
 1. Array/Collection Transformations: Using functions like map, filter, and reduce allows for clean, concise transformation of arrays and collections.
 2. Code Reusability: You can pass custom behaviors (closures) into functions, making your code more reusable.
 3. Event Handling: Higher-order functions are useful for responding to events or conditions in event-driven programming, such as in SwiftUI or UIKit.
 4. Function Composition: You can break down complex operations into simpler, reusable functions, then compose them together for more modular and maintainable code.
 Summary of Higher-Order Function Benefits:
 * Conciseness: They allow for concise and expressive code, reducing boilerplate.
 * Modularity: They promote the separation of logic into smaller, reusable components.
 * Declarative Code: Higher-order functions help write code that focuses on what you want to do, rather than how to do it.
 * Functional Programming: They align with the principles of functional programming, making it easier to apply functional techniques such as immutability and side-effect-free functions.
 Higher-order functions are an essential feature in Swift that allow for more expressive, flexible, and reusable code.

 
 */

