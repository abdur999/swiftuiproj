//
//  Protocol.swift
//  swiftui
//
//  Created by Abdur Rahim on 11/09/24.
//

import Foundation
protocol Shape {
    func draw() -> String
}

struct CCircle: Shape {
    func draw() -> String {
        return "Drawing a circle"
    }
}

struct Square: Shape {
    func draw() -> String {
        return "Drawing a square"
    }
}
struct Execute {
    func createPattern() {
        let shape = makeShape()
        print(shape.draw())
    }
    
    // Using protocol type
    func makeShape() -> Shape {
        return CCircle()
    }
    
    // Using opaque type
    func makeOpaqueShape() -> some Shape {
        return CCircle()
    }
    func pair<T: Shape>(_ shape: T) -> (some Shape, some Shape) {
        return (shape, flip(shape))
    }
    
    
    //when you use some protocol as return type you cannot choose any of them you have to return a single type only (eg either Square or Circle)
    // 1. return same concrete type in all return paths
    // 2. Use a protocol-based return type instead of opaque types if you need flexlibility to return different types.
    
    //This function return opaque type so only one kind of object should return(only one concrete type should return, here it will be either Square or CCircle)
    func flip<T: Shape>(_ shape: T) -> some Shape {
        //    if shape is CCircle {
        return Square()
        //    }
        //    return CCircle()
    }
    
    //This function return protocol type so we can return anytype which implement the protocol
    func gflip<T: Shape>(_ shape: T) -> Shape {
        if shape is CCircle {
            return Square()
        }
        return CCircle()
    }
    
    func createPattern2() {
        let shape1 = makeShape()
        let shape2 = makeOpaqueShape()
        
        print(shape1.draw())  // Output: Drawing a circle
        print(shape2.draw())  // Output: Drawing a circle
    }
    
}
/*
 OPAQUE TYPE (some protocol)
 Advantages:
 * Opaque types allow the compiler to retain knowledge of the concrete type, leading to better optimizations.
 * You still provide abstraction (the caller doesn't need to know the exact type) but without the overhead of type erasure.
 Disadvantages:
 * You cannot return different types from a function using some protocol. All code paths must return the same concrete type.
 
 Key Differences:
 Feature                    Protocol (Existential Type)                     some protocol (Opaque Type)
 -------                    ----------------------------                    ----------------------------
 Type Information           Type-erased (caller doesn't know the type)      Type known to the compiler but hidden from the caller
 Return Different Types     Yes, can return different types conforming      No, must return the same concrete type
                            to the protocol
 
 
 Use Case                   When you need to return different types          When you want to hide the concrete type but return the same type
                            conforming to a protocol
 
 Performance                Slight overhead due to type erasure             More performant because the type is known at compile time

 
 
 */


/*
 PROTOCOL
 --------
 In Swift, a protocol is a blueprint that defines methods, properties, and other requirements for tasks or functionalities that conforming types must implement. Protocols enable a powerful form of abstraction, allowing developers to define shared behavior across different types, regardless of their implementation.
 Here are key features and concepts of Swift protocols:
 1. Defining a Protocol
 A protocol defines a list of requirements (methods, properties, etc.) that conforming types (classes, structs, or enums) must satisfy.
 swift
 Copy code
 protocol Vehicle {
     var speed: Double { get set }
     func accelerate()
 }
 * In the Vehicle protocol, we require any conforming type to have a speed property and an accelerate method.
 2. Protocol Conformance
 Any type (struct, class, or enum) can conform to a protocol by implementing all the required properties and methods defined in the protocol.
 swift
 Copy code
 struct Car: Vehicle {
     var speed: Double = 0.0
     
     func accelerate() {
         speed += 10.0
     }
 }
 * Car conforms to the Vehicle protocol by implementing the speed property and the accelerate method.
 3. Properties in Protocols
 Protocols can define both read-only and read-write properties. Types conforming to the protocol must implement the properties as specified.
 * Read-Only Property: var property: Type { get }
 * Read-Write Property: var property: Type { get set }
 swift
 Copy code
 protocol Animal {
     var name: String { get }
     var age: Int { get set }
 }
 In this example:
 * name is a read-only property.
 * age is a read-write property.
 4. Methods in Protocols
 Protocols can define instance or static methods that conforming types must implement.
 swift
 Copy code
 protocol Describable {
     func describe() -> String
     static func describeType() -> String
 }
 * describe() is an instance method.
 * describeType() is a static method.
 5. Mutating Methods
 For value types (structs and enums), methods that modify self must be marked with the mutating keyword in the protocol.
 swift
 Copy code
 protocol Resettable {
     mutating func reset()
 }

 struct Counter: Resettable {
     var count = 0
     
     mutating func reset() {
         count = 0
     }
 }
 The mutating keyword allows the method to modify the properties of the struct or enum that implements the protocol.
 6. Protocol Inheritance
 Protocols can inherit from one or more other protocols, combining their requirements.
 swift
 Copy code
 protocol Identifiable {
     var id: String { get }
 }

 protocol Nameable: Identifiable {
     var name: String { get }
 }

 struct User: Nameable {
     var id: String
     var name: String
 }
 In this case, Nameable inherits from Identifiable, meaning any type conforming to Nameable must also satisfy Identifiable requirements.
 7. Associated Types
 Protocols can define associated types, which are placeholders for types that are used inside the protocol. This makes the protocol generic and flexible.
 swift
 Copy code
 protocol Container {
     associatedtype Item
     func add(item: Item)
     func getItem(at index: Int) -> Item
 }
 A type conforming to Container must specify what Item is, but Item can vary for different conforming types.
 swift
 Copy code
 struct IntContainer: Container {
     var items: [Int] = []
     
     func add(item: Int) {
         items.append(item)
     }
     
     func getItem(at index: Int) -> Int {
         return items[index]
     }
 }
 8. Protocol Extensions
 Protocols can be extended to provide default implementations of methods or computed properties. This allows all conforming types to automatically get this behavior without needing to implement it themselves.
 swift
 Copy code
 protocol Greetable {
     func greet()
 }

 extension Greetable {
     func greet() {
         print("Hello!")
     }
 }

 struct Person: Greetable {}

 let person = Person()
 person.greet() // Prints: Hello!
 Here, the greet() method has a default implementation. Any type that conforms to Greetable can use the default implementation without explicitly defining it.
 9. Protocol-Oriented Programming
 Swift encourages protocol-oriented programming, where protocols are used to define the behavior and structure of types, and default behavior is provided via protocol extensions. This paradigm allows for better abstraction and code reuse.
 10. Protocol as a Type
 Protocols can be used as types for variables, constants, and function parameters/return types. This is known as an existential type.
 swift
 Copy code
 func printDescription(item: Describable) {
     print(item.describe())
 }
 Here, printDescription accepts any type that conforms to the Describable protocol.
 11. Opaque Return Types (some keyword)
 Swift allows you to return an opaque type from a function using the some keyword. This means the function returns a value of some type that conforms to the protocol, but the concrete type is hidden.
 swift
 Copy code
 func makeShape() -> some Shape {
     return Circle(radius: 5)
 }
 12. Protocol Composition
 You can compose multiple protocols together using the & operator to require a type to conform to multiple protocols.
 swift
 Copy code
 protocol Drivable {
     func drive()
 }

 protocol Flyable {
     func fly()
 }

 func travel(vehicle: Drivable & Flyable) {
     vehicle.drive()
     vehicle.fly()
 }
 13. Optional Protocol Requirements (Objective-C Interoperability)
 When working with Objective-C code, Swift allows protocols to have optional requirements. This is done using the @objc attribute and is typically used for protocols interacting with Objective-C frameworks like UIKit.
 swift
 Copy code
 @objc protocol Delegate {
     @objc optional func didFinishTask()
 }
 However, this is rarely used in pure Swift code, as Swift prefers explicit conformance.
 14. Protocol Conformance Checking (is and as)
 You can check whether a type conforms to a protocol using the is keyword and downcast to a protocol type using as.
 swift
 Copy code
 if item is Describable {
     print("Item is describable")
 }

 if let describableItem = item as? Describable {
     print(describableItem.describe())
 }
 Summary of Swift Protocol Features:
 * Method, property, and subscript requirements
 * Associated types for flexible generic protocols
 * Protocol inheritance for extending protocols
 * Default implementations through protocol extensions
 * Protocol composition using & for multiple conformances
 * Existential types for using protocols as types
 * Opaque return types using some protocol
 * Optional requirements (when interoperating with Objective-C)
 * Protocol-oriented programming promotes reusable and modular code design
 Swift protocols are an essential part of the language, allowing for abstraction, code reuse, and flexible type systems.
 */
