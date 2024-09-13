//
//  KvoKvc.swift
//  swiftui
//
//  Created by Abdur Rahim on 13/09/24.
//

import Foundation

/*
 KVO is used for observing changes to the properties of an object. When a property value changes, observers are notified. It’s typically used to observe changes to properties, often for purposes like updating UI elements when data changes, responding to model changes, etc.

 KVO relies on the Objective-C runtime to observe changes to properties. The observed object must subclass NSObject, and the observed properties must be marked with @objc dynamicattributes, @objc means you want your Swift code to be visible from Objective-C, dynamic means you want to use Objective-C dynamic dispatch.
 */
class BankAccount: NSObject {
    @objc dynamic var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) {
        if balance >= amount {
            balance -= amount
        } else {
            print("Insufficient funds!")
        }
    }
}

class AccountManager: NSObject {
    @objc var accountToMonitor: BankAccount
    var balanceObservation: NSKeyValueObservation?
    
    init(account: BankAccount) {
        accountToMonitor = account
        super.init()
        
        // Set up KVO for the balance property
        balanceObservation = observe(
            \.accountToMonitor.balance,
             options: [.old, .new]
        ) { object, change in
            if let newBalance = change.newValue {
                print("Balance changed: $\(newBalance)")
            }
        }
    }
}
/*
 KVC is used for accessing an object’s properties indirectly through string-based keys. It allows getting and setting property values dynamically using strings. It’s typically used when you need to access properties dynamically, such as when parsing JSON, dealing with user defaults, or when working with dictionaries.

 KVC also relies on the Objective-C runtime for dynamic property access. Similarly, the class must subclass NSObject, and properties need to be marked with @objc.
 */
class Pproduct: NSObject {
    @objc dynamic var productName: String = ""
    @objc dynamic var price: Double = 0.0
}


struct SampleKvoKvc {
    func sampleKVO() {
        // Create a bank account
        let myAccount = BankAccount()
        
        // Create an account manager to observe the account
        let manager = AccountManager(account: myAccount)
        
        // Perform some transactions
        myAccount.deposit(amount: 1000)
        myAccount.withdraw(amount: 500)
        myAccount.deposit(amount: 200)
        
        // Clean up (remove the observer)
        manager.balanceObservation = nil
    }
    func sampleKVC() {
        let myProduct = Pproduct()

        // Set values using KVC (Key-Value Coding)
        myProduct.setValue("Smartphone", forKey: "productName")
        myProduct.setValue(799.99, forKey: "price")

        // Retrieve values using KVC
        if let productName = myProduct.value(forKey: "productName") as? String {
            print("Product Name: \(productName)")
        }

        // Accessing using dot notation for comparison
        print("Price: $\(myProduct.price)")
    }
}

/*
 Here’s why their popularity has waned:

 Swift’s native property observers (willSet and didSet) provide a cleaner way to observe property changes compared to KVO.
 KVO and KVC operate based on stringly-typed keys, which can lead to runtime errors if the key names aren’t correct
 Modern Swift development often favors functional and reactive programming paradigms, where frameworks like Combine and RxSwift offer more powerful and composable ways to handle asynchronous events and data flow, making KVO less necessary.
 KVO involves runtime overhead, as it relies on Objective-C runtime features. In performance-critical scenarios, developers may choose alternative mechanisms to achieve similar functionality with lower overhead.
 When working with existing Objective-C codebases that heavily rely on KVO and KVC, you might need to use them for compatibility.
 */
