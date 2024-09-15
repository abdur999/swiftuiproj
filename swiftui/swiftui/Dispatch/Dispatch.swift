//
//  Dispatch.swift
//  swiftui
//
//  Created by Abdur Rahim on 13/09/24.
//

import Foundation


/*
 
                            Direct             Table              Message
 
 Explicitly enforced    final, static           -                  dynamic
 
 Value type             all methods             -                   -
 
 Protocols              extensions         initial declaration      -
 
 Class                  extensions      initial declaration         extensions with @objc
 
 */


/*
 Since struct and enum are value types and does not support inheritance, the compiler puts it under Static dispatch as it is aware of the fact that it can never be subclassed.
 */
struct Personc {
    func isIrritating() -> Bool { return true } // Static
}

extension Personc {
    func canBeEasilyPissedOff() -> Bool { return false } // Static
}

/*
 The key point to note here is that any method defined inside extension uses Static Dispatch
 */
protocol Animal {
    func isCute() -> Bool // Table
}

extension Animal {
    func canGetAngry() -> Bool { return false } // Static
}
/*
 Normal method declarations follow the same principles as protocol
 Whenever we expose a method to Objective-C runtime using @objc, the method uses Message Dispatch
 However, if we mark a class as final, that class cannot be subclassed and thus its methods use Static Dispatch.
 */
class Dog: Animal {
    func isCute() -> Bool { return true } // Table
    @objc dynamic func hoursSleep() -> Int { return 1 } // Message
}

extension Dog {
    func canBite() -> Bool { return true } // Static
    @objc func goWild() { } // Message
}

final class Employee {
    func canCode() -> Bool { } // Static
}
