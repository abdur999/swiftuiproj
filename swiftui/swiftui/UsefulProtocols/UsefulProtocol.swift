//
//  UsefulProtocol.swift
//  swiftui
//
//  Created by Abdur Rahim on 12/09/24.
//

import Foundation
struct Person: Equatable {
    var name: String
    var age: Int
}
struct Product: Comparable {
    var name: String
    var price: Double
    
    static func < (lhs: Product, rhs: Product) -> Bool {
        return lhs.price < rhs.price
    }
}

struct User: Hashable {
    var username: String
}

struct Book: Codable {
    var title: String
    var author: String
}

struct Movie: CustomStringConvertible {
    var title: String
    var director: String
    
    var description: String {
        return "\(title) by \(director)"
    }
}

struct Countdown: Sequence {
    let start: Int
    
    func makeIterator() -> some IteratorProtocol {
        return CountdownIterator(current: start)
    }
}

struct CountdownIterator: IteratorProtocol {
    var current: Int
    
    mutating func next() -> Int? {
        if current >= 0 {
            let value = current
            current -= 1
            return value
        } else {
            return nil
        }
    }
}

struct DeviceOptions: OptionSet {
    let rawValue: Int
    
    static let wifi   = DeviceOptions(rawValue: 1 << 0)
    static let bluetooth = DeviceOptions(rawValue: 1 << 1)
    static let gps    = DeviceOptions(rawValue: 1 << 2)
}




struct UsefulProtocol {
    func equata() {
        let person1 = Person(name: "John", age: 30)
        let person2 = Person(name: "Jane", age: 25)
        let areEqual = person1 == person2  // false
    }
    func compare() {
        let product1 = Product(name: "Phone", price: 799)
        let product2 = Product(name: "Laptop", price: 1299)
        let isCheaper = product1 < product2  // true
    }
    func useHashable() {
        let user1 = User(username: "JohnDoe")
        let user2 = User(username: "JaneDoe")
        let userSet: Set = [user1, user2]
    }
    func usecodable() {
        let jsonData = """
        {
            "title": "Swift Programming",
            "author": "Apple Inc."
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let book = try? decoder.decode(Book.self, from: jsonData)
    }
    func customStringConvertible(){
        let movie = Movie(title: "Inception", director: "Christopher Nolan")
        print(movie)  // Prints: Inception by Christopher Nolan
    }
    func iteratorex() {
        for number in Countdown(start: 5) {
            print(number)
        }
    }
    func useOptionSet() {
        let options: DeviceOptions = [.wifi, .bluetooth]
        print(options.contains(.wifi))  // true
    }
}

/*
 
 In Swift, protocols define a blueprint of methods, properties, and other requirements that conforming types must implement. Some protocols are widely used across the Swift language and are essential for developing Swift applications. Here's a list of important Swift protocols and their use cases:
 1. Equatable
 The Equatable protocol allows a type to be compared for equality using the == and != operators.
 * Use Case: When you want to compare two instances of a type to check if they are equal.
 Example:
 swift
 Copy code
 struct Person: Equatable {
     var name: String
     var age: Int
 }

 let person1 = Person(name: "John", age: 30)
 let person2 = Person(name: "Jane", age: 25)
 let areEqual = person1 == person2  // false
 * Conforming to Equatable automatically enables the == and != operators.
 2. Comparable
 The Comparable protocol allows a type to be compared using relational operators (<, <=, >, >=).
 * Use Case: Sorting and ordering types that conform to Comparable.
 Example:
 swift
 Copy code
 struct Product: Comparable {
     var name: String
     var price: Double
     
     static func < (lhs: Product, rhs: Product) -> Bool {
         return lhs.price < rhs.price
     }
 }

 let product1 = Product(name: "Phone", price: 799)
 let product2 = Product(name: "Laptop", price: 1299)
 let isCheaper = product1 < product2  // true
 * Conforming to Comparable allows types to be compared and sorted.
 3. Hashable
 The Hashable protocol allows a type to be hashed, enabling it to be stored in collections such as Set or as dictionary keys.
 * Use Case: When you need to use a type as a key in a dictionary or store instances in a Set.
 Example:
 swift
 Copy code
 struct User: Hashable {
     var username: String
 }

 let user1 = User(username: "JohnDoe")
 let user2 = User(username: "JaneDoe")
 let userSet: Set = [user1, user2]
 * Hashable types can be hashed to an integer value and used in sets and dictionaries.
 4. Codable (Encodable and Decodable)
 The Codable protocol is a combination of Encodable and Decodable, allowing types to be encoded to or decoded from external representations (like JSON).
 * Use Case: When you want to serialize and deserialize data, such as saving data to disk or sending data over the network.
 Example:
 swift
 Copy code
 struct Book: Codable {
     var title: String
     var author: String
 }

 let jsonData = """
 {
     "title": "Swift Programming",
     "author": "Apple Inc."
 }
 """.data(using: .utf8)!

 let decoder = JSONDecoder()
 let book = try? decoder.decode(Book.self, from: jsonData)
 * Codable is commonly used for converting types to/from JSON, XML, or other data formats.
 5. CustomStringConvertible
 The CustomStringConvertible protocol provides a custom textual representation of a type by overriding the description property.
 * Use Case: When you want to customize how an instance is printed or logged.
 Example:
 swift
 Copy code
 struct Movie: CustomStringConvertible {
     var title: String
     var director: String
     
     var description: String {
         return "\(title) by \(director)"
     }
 }

 let movie = Movie(title: "Inception", director: "Christopher Nolan")
 print(movie)  // Prints: Inception by Christopher Nolan
 * Conforming to CustomStringConvertible allows for more informative output when printing or logging instances.
 6. Sequence
 The Sequence protocol represents a type that can be iterated over. Many of Swift’s collection types (like Array, Set, etc.) conform to this protocol.
 * Use Case: When you want to create a custom collection or type that can be iterated over in a for loop.
 Example:
 swift
 Copy code
 struct Countdown: Sequence {
     let start: Int
     
     func makeIterator() -> some IteratorProtocol {
         return CountdownIterator(start: start)
     }
 }

 struct CountdownIterator: IteratorProtocol {
     var current: Int
     
     mutating func next() -> Int? {
         if current >= 0 {
             let value = current
             current -= 1
             return value
         } else {
             return nil
         }
     }
 }

 for number in Countdown(start: 5) {
     print(number)
 }
 * Implementing Sequence allows for iteration using for loops and provides access to many sequence-related methods.
 7. IteratorProtocol
 IteratorProtocol defines how a sequence is iterated over. It is often used together with the Sequence protocol.
 * Use Case: When creating custom sequences and iterators.
 Example:
 swift
 Copy code
 struct FibonacciIterator: IteratorProtocol {
     var current = 0
     var nextValue = 1
     
     mutating func next() -> Int? {
         let value = current
         current = nextValue
         nextValue += value
         return value
     }
 }

 var fibonacci = FibonacciIterator()
 for _ in 0..<10 {
     print(fibonacci.next()!)
 }
 * Conforming to IteratorProtocol allows a custom way to generate the next element in a sequence.
 8. OptionSet
 OptionSet is a protocol that allows a type to represent a set of discrete options, using bitwise operations for efficient storage.
 * Use Case: When working with combinations of options or settings.
 Example:
 swift
 Copy code
 struct DeviceOptions: OptionSet {
     let rawValue: Int
     
     static let wifi   = DeviceOptions(rawValue: 1 << 0)
     static let bluetooth = DeviceOptions(rawValue: 1 << 1)
     static let gps    = DeviceOptions(rawValue: 1 << 2)
 }

 let options: DeviceOptions = [.wifi, .bluetooth]
 print(options.contains(.wifi))  // true
 * OptionSet is commonly used for defining sets of options (e.g., file permissions, configuration flags).
 9. Result
 Result is a built-in type in Swift that uses Success and Failure cases to handle operations that can either succeed or fail.
 * Use Case: For handling success and failure cases in asynchronous or potentially failing operations.
 Example:
 swift
 Copy code
 enum NetworkError: Error {
     case badURL
 }

 func fetchData(from url: String) -> Result<String, NetworkError> {
     if url == "validURL" {
         return .success("Data received")
     } else {
         return .failure(.badURL)
     }
 }

 let result = fetchData(from: "invalidURL")
 switch result {
 case .success(let data):
     print(data)
 case .failure(let error):
     print("Failed with error: \(error)")
 }
 * Result simplifies error

 
 */
