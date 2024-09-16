//
//  DeepDiveCombine.swift
//  swiftui
//
//  Created by Abdur Rahim on 16/09/24.
//

import Foundation
import Combine
class DeepDiveCombine {
    var subscriptions = Set<AnyCancellable>()
    
    // TRANSFORMING OPERATORS
    
    // Scan
    //It is similtar to Swift reduce. Provides a stream with accumulated values. The closure receives two parameters, the last value and the next.
    func removeDuplicates() {
        ["a", "b", "c"]
            .publisher
            .scan("X ->") { latest, current in
                "\(latest) + \(current)"
            }
            .sink(receiveValue: {
                print("sink \($0)")
            })
            .store(in: &subscriptions)
    }
    // Collect
    // It is used to transform invidual values into an array.
    func collect() {
        
        let publisher = PassthroughSubject<Int, Never>()

        publisher
            .collect()
            .sink(receiveValue: {
                print("all values as array: ")
                print($0)
            }).store(in: &subscriptions)

        publisher
            .collect(2)
            .sink(receiveValue: {
                print("array elements limited by 2: ")
                print($0)
            }).store(in: &subscriptions)

        publisher.send(1)
        publisher.send(2)
        publisher.send(3)
        publisher.send(completion: .finished)
    }
    // Map and FlatMap
    // Map functions similarly to Swift’s standard, but with the distinction that it acts on values emitted from a publisher. Additionally, it offers the flexibility to map into one, two, or three properties of a value using key paths.
    func mapAndFlatMap1() {
        
        struct User {
            let name: String
            let lastName: String
        }
        let user = User(name: "John", lastName: "Snow")
        let publisher = PassthroughSubject<User, Never>()

        publisher
            .map(\.name, \.lastName)
            .sink(receiveValue: { name, lastName in
                print("name: \(name)")
                print("last name: \(lastName)")
            })
            .store(in: &subscriptions)

        publisher.send(user)
    }
    func mapAndFlatMap2() {
        let nestedArray = [[1,2,3],[4,5],[6]]
        let flattened = nestedArray.flatMap{ $0 }
        let mapped = nestedArray.map { $0 }

        print("mapped: \(mapped)") // [[1, 2, 3], [4, 5], [6]]
        print("flattened \(flattened)") // [1, 2, 3, 4, 5, 6]
    }
    
    func intToString(_ input: Int) -> AnyPublisher<String, Never> {
        return Just("number: \(input)").eraseToAnyPublisher()
    }
    func mapAndFlatMap3() {
        let array = [1]

        array.publisher
            .map(intToString)
            .sink(receiveValue: { publisher in
                print(publisher) // AnyPublisher
            })
            .store(in: &subscriptions)

        array.publisher
            .flatMap(intToString)
            .sink(receiveValue: { string in
                print(string) // number: 1
            })
            .store(in: &subscriptions)
    }
    // Replace nil and Replace Empty
    // ReplacingEmptyWith is similar to setting a default value in the event that the publisher completes without emitting any values.
    func nilWithempty() {
        ["A", nil, "C"].publisher
            .eraseToAnyPublisher()
            .replaceNil(with: "-")
            .sink(receiveValue: { print($0) }) // A - C
            .store(in: &subscriptions)
    }
    func nilWithEmpty2() {
        var subscriptions = Set<AnyCancellable>()

        let empty = Empty<Int, Never>()

        empty
            .replaceEmpty(with: 5)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    
    
    // FILTERING OPERATORS
    // The Filter Operator takes a closure that returns a Bool, allowing only values that match the provided conditions to pass through. It enables you to control which values emitted by the upstream publisher are sent downstream.
    
    // Remove duplicates
    // It automatically works for any values conforming to Equatable, including String. It will not pass down identical values.
    func removeDuplicate() {
        var subscriptions = Set<AnyCancellable>()

        ["a", "a", "b", "b", "c", "d", "e", "e", "e"]
            .publisher
                .removeDuplicates()
                .sink(receiveValue: { print($0) })
                .store(in: &subscriptions)
    }
    // Compacting and ignoring
    // When dealing with a publisher emitting Optional values or operation that might return nil.
    func compactIgnore() {
        var subscriptions = Set<AnyCancellable>()
        let strings = ["a", "1.24", "3",
                       "def", "45", "0.23"].publisher

        strings
            .compactMap { Float($0) }
            .sink(receiveValue: {
                print($0) })
            .store(in: &subscriptions)
    }
    func compactIgnoreOutput() {
        let numbers = (1...10_000).publisher
        numbers
            .ignoreOutput()
            .sink(receiveCompletion: { print("Completed with: \($0)") },
                  receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    
    // Finding values
    // Find and emit only the first or the last value matching the provided condition. Is another sort of filtering, where you can find the first or last values to match a provided predicate using first(where:) and last(where:), respectively.
    func findingValues() {
        let numbers = (1...9).publisher
        numbers
            .first(where: { $0 % 2 == 0 })
            .sink(receiveCompletion: { print("Completed with: \($0)") },
                  receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    func findingValues2() {
        let numbers = (1...9).publisher
        numbers
            .last(where: { $0 % 2 == 0 })
            .sink(receiveCompletion: { print("Completed with: \($0)") },
                  receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    // Dropping values
    // We can use it when you want to ignore values from one publisher until a second one starts publishing, or if you want to ignore a specific amount of values at the start of the stream. It enable us to control how many values emitted by the upstream publisher are ignored before sending values downstream by using the drop family of operators.
    func droppingValues() {
        let numbers = (1...10).publisher
        numbers
            .dropFirst(8)
            .sink(receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    func droppingValues2() {
        let numbers = (1...10).publisher
        numbers
            .drop(while: { $0 % 5 != 0 })
            .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    }
    func droppingValues3() {
        let numbers = (1...10).publisher
        numbers
            .prefix(2)
            .sink(receiveCompletion: {
                print("Completed with: \($0)")
            }, receiveValue: {
                print($0)
            })
            .store(in: &subscriptions)
    }
    
    // COMBINING OPERATORS
    // This set of operators lets you combine events emitted by different publishers and create meaningful combinations of data in your Combine code.
    
    // Append & Prepend
    // Allow us to add values that emit before/after any values from your original publisher.
    func prependCall() {
        let publisher = [5, 6, 7].publisher
        publisher
            .prepend([3, 4])
            .prepend(Set(1...2))
            .sink(receiveValue: { print($0) })
            .store(in: &subscriptions)
        
        let publisher1 = [3, 4].publisher
        let publisher2 = [1, 2].publisher
        
        publisher1
            .prepend(publisher2)
            .sink(receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    func appendCall() {
        let publisher = [1].publisher
        publisher
            .append(2, 3)
            .append(4)
            .sink(receiveValue: { print($0) })
            .store(in: &subscriptions)
    }
    // Switch To Latest
    // This operator is specifically designed for publishers that emit other publishers (nested publishers), where the parent publisher acts as a manager for the operations of the child publishers. As the name implies, this operator removes the current publisher operation and switches to the latest one that was emitted.
    func switchToLatest() {
        let childPublisher1 = PassthroughSubject<Int, Never>()
        let childPublisher2 = PassthroughSubject<Int, Never>()
        let parentPublisher = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()

        parentPublisher
            .switchToLatest()
            .sink(receiveCompletion: {
                print("completion: \($0)")
            }, receiveValue: {
                print("sink: \($0)")
            })
            .store(in: &subscriptions)

        parentPublisher.send(childPublisher1)
        childPublisher1.send(1)
        parentPublisher.send(childPublisher2) // removes the childPublisher1 subscription
        childPublisher1.send(1) // will not be printed
        childPublisher2.send(2)
        childPublisher2.send(2)
    }
    
    // Switching between asynchronous operations, such as a Network Request, is a common use case for switchToLatest operator.
    func switchToLatestAsync() {
        let parentPublisher1 = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
        let parentPublisher2 = PassthroughSubject<AnyPublisher<Int, Never>, Never>()

        func requestLowNumber() -> AnyPublisher<Int, Never> {
            let delay = 1.0
            let publisher = PassthroughSubject<Int, Never>()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                let randomResult = Int.random(in: 1...10)
                publisher.send(randomResult)
            }
            return publisher.eraseToAnyPublisher()
        }

        func requestHighNumber() -> AnyPublisher<Int, Never> {
            let delay = 2.0
            let publisher = PassthroughSubject<Int, Never>()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                let randomResult = Int.random(in: 1000...10000)
                publisher.send(randomResult)
            }
            return publisher.eraseToAnyPublisher()
        }

        parentPublisher1
            .switchToLatest()
            .sink(receiveValue: {
                print("parentPublisher1: \($0)")
            })
            .store(in: &subscriptions)

        parentPublisher2
            .switchToLatest()
            .sink(receiveValue: {
                print("parentPublisher2: \($0)")
            })
            .store(in: &subscriptions)

        // low and high will be printed
        parentPublisher1.send(requestLowNumber()) //needs to wait one second to be printed
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            parentPublisher1.send(requestHighNumber())
        }

        // just high number will be printed
        parentPublisher2.send(requestLowNumber()) // will unsubscribe before the print operation finishes
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            parentPublisher2.send(requestHighNumber())
        }
    }
    
    // Merge
    // The merge operator allows us to simultaneously observe multiple publishers while maintaining the order of execution for each sent value. This operator makes it possible to combine different publishers.
    func combineMultplePublisher() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<Int, Never>()
        let publisher3 = PassthroughSubject<Int, Never>()

        publisher1
            .merge(with: publisher2)
            .merge(with: publisher3)
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &subscriptions)

        publisher1.send(1)
        publisher2.send(2)
        publisher3.send(3)
        publisher1.send(1)
        publisher2.send(2)
        publisher2.send(2)
        publisher3.send(3)
    }
    // Combine Latest
    // This operator allows us to combine publishers of different value types by emitting a tuple with the latest values of all publishers. Every publisher passed to combineLatest, including the origin publisher, must emit at least one value to fire the downstream. Additionally, to finish the origin publisher subscription, every publisher passed to combineLatest must complete.
    func combineLatestPublisher() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        let publisher3 = PassthroughSubject<URL, Never>()
        let publisher4 = PassthroughSubject<Bool, Never>()


        publisher1
            .combineLatest(publisher2)
            .combineLatest(publisher3)
            .combineLatest(publisher4)
            .sink(receiveCompletion: { completion in
                print("completion: \(completion)")
            }, receiveValue: { value in
                print("tupple of all latest emitted values: \(value)")
                print("latest value emmited: \(value.1)")
            })
            .store(in: &subscriptions)

        publisher1.send(1)
        publisher1.send(2)
        publisher2.send("a")
        publisher2.send("b")
        publisher1.send(3)
        publisher2.send("c")
        publisher3.send(URL(string: "www.apple.com")!)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            // it will wait the last publisher emit a value
            publisher4.send(true)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            // finish the origin publisher
            publisher1.send(completion: .finished)
            publisher2.send(completion: .finished)
            publisher3.send(completion: .finished)
            publisher4.send(completion: .finished)
        }
    }
    // Zip
    // It waits for each publisher to emit an item, then emits a tuple. If we are zipping two publishers, we will get a single tuple emitted every time both publishers emit a value.
    func zipPublishers() {
        var subscriptions = Set<AnyCancellable>()

        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()

        publisher1
            .zip(publisher2)
            .sink(receiveCompletion: { _ in
                print("Completed")
            }, receiveValue: {
                print("P1: \($0), P2: \($1)")
            })
            .store(in: &subscriptions)

            publisher1.send(1)
            publisher1.send(2)
            publisher2.send("a")
            publisher2.send("b")
            publisher1.send(3)
            publisher2.send("c")
            publisher2.send("d") // it will not be printed

            publisher1.send(completion: .finished)
            publisher2.send(completion: .finished)
    }
    
    
    // TIME MANIPULATION OPERATORS
    // Every time the upstream publisher emits a value, the time manipulation opertors are able to coordinate the downstream with time configurations.
    // This function below will help us compare the monent that the value was sent with its arrival time.
    func timeManipulation() {
        func getTime() -> String {
            let date = Date()
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: date)
            let hour = components.hour
            let minutes = components.minute
            let seconds = components.second
            return "\(hour!):\(minutes!):\(seconds!)"
        }
    }
    
    // Delay
    // It keeps the emitted value for a while then emits it after the delay you asked for.
    func delay() {
        let sourcePublisher = PassthroughSubject<Bool, Never>()

        sourcePublisher
            .delay(for: .seconds(5), scheduler: DispatchQueue.main)
            .sink(receiveValue: {  [weak self] _ in
                print("received: \(self?.getTime())")
            })
            .store(in: &subscriptions)

        print("sent: \(getTime())")
        sourcePublisher.send(true)
    }
    
    // Collect byTime or Count
    // This operator is employed to gather values emitted by a publisher at specified intervals or based on the number of times values were sent.. It transforms all values in an Array by default.
    func collectByTime() {
        let sourcePublisher = PassthroughSubject<String, Never>()

        sourcePublisher
            .collect(.byTimeOrCount(DispatchQueue.main, .seconds(3), 2))
            .sink(receiveValue: { [weak self] currentTime in
                print("time sent: \(currentTime) / received time: \(self?.getTime())")
            })
            .store(in: &subscriptions)

        sourcePublisher
            .collect(.byTimeOrCount(DispatchQueue.main, .seconds(3), 1))
            .sink(receiveValue: { [weak self] currentTime in
                //will not wait the interval
                print("time sent: \(currentTime) / received time: \(self?.getTime())")
            })
            .store(in: &subscriptions)

        let currentTime = getTime()
        sourcePublisher.send(currentTime)
    }
    
    // Debounce
    // It waits for one second on emissions from subject. Then, it will send the last value sent in that one-second interval, if any. This has the effect of allowing a max of one value per second.
    func debounce() {
        let sourcePublisher = PassthroughSubject<String, Never>()

        sourcePublisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                print("value: \(value)")
                print("received time: \(self?.getTime())")
            })
            .store(in: &subscriptions)

        sourcePublisher.send("a")
        sourcePublisher.send("b")
        sourcePublisher.send("c")
        sourcePublisher.send("d")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            sourcePublisher.send("e")
        }
    }
    
    func getTime() -> String {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        return "\(hour!):\(minutes!):\(seconds!)"
    }
    
    // Throttle
    // It is close to debounce. It publishes the most-recent element in the specified time interval. When the subject emits its first value, throttle immediately relays it. Then, it starts throttling the output.
    func throttle() {
        let sourcePublisher = PassthroughSubject<String, Never>()

        sourcePublisher
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: false)
            .sink(receiveValue: { [weak self] value in
                print("value: \(value)")
                print("received time: \(self?.getTime())")
            })
            .store(in: &subscriptions)

        sourcePublisher.send("a")
        sourcePublisher.send("b")
        sourcePublisher.send("c")
        sourcePublisher.send("d")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            sourcePublisher.send("e")
        }
    }
    
    // Timeout
    // It forces a publisher completion after a time interval.
    func timeoutCall() {
        let sourcePublisher = PassthroughSubject<String, Never>()

        sourcePublisher
            .timeout(.seconds(2), scheduler: DispatchQueue.main, customError: nil)
            .sink(receiveCompletion: {
                print("completion time: \(self.getTime()) \($0)")
            }, receiveValue: {
                print("time sent: \($0)")
            })
            .store(in: &subscriptions)

        let currentTime = getTime()
        sourcePublisher.send("\(currentTime)")
    }
    
    
    // SEQUENCE OPERATORS
    // These operators operate on the collection of values emitted by a publisher, handling the sequence as a whole rather than individual values.
    
    // Min/Max
    func minMax() {
        let publisher = [1, -50, 246, 0].publisher

        publisher
            .min()
            .sink(receiveValue: { print("Lowest value: \($0)") })
                .store(in: &subscriptions)
                
        publisher
            .max()
            .sink(receiveValue: { print("Highest value: \($0)") })
            .store(in: &subscriptions)
    }
    // First/Last
    func firstLast() {
        let publisher = ["A", "B", "C"].publisher

        publisher
            .first()
            .sink(receiveValue: { print("First value: \($0)") })
            .store(in: &subscriptions)
            
        publisher
            .last()
            .sink(receiveValue: { print("Last value: \($0)") })
            .store(in: &subscriptions)
    }
    // Output out/in
    func getRangeOrIndex() {
        let publisher = ["A", "B", "C", "D", "E"].publisher

        publisher
            .output(at: 1)
            .sink(receiveValue: { print("Value at index 1 is \($0)") })
            .store(in: &subscriptions)

        publisher
            .output(in: 2...4)
            .sink(receiveCompletion: { print($0) },
                  receiveValue: { print("Value in range: \($0)") })
            .store(in: &subscriptions)
    }
    
    
    // QUERYING OPERATOR
    // They don’t produce any specific value that it emits. Instead, these operators emit a different value representing some query on the publisher as a whole.
    
    // Count
    func getCount() {
        let publisher = ["A", "B", "C"].publisher

        publisher
            .count()
            .sink(receiveValue: { print("I have \($0) items") })
            .store(in: &subscriptions)
    }
    // Contains
    func getContains() {
        let publisher = ["A", "B", "C", "D", "E"].publisher

        publisher
            .contains("C")
            .sink(receiveValue: { contains in
                print("Publisher emitted C? \(contains)")
            })
            .store(in: &subscriptions)

        publisher
            .contains("Z")
            .sink(receiveValue: { contains in
                print("Publisher emitted Z? \(contains)")
            })
            .store(in: &subscriptions)
    }
    // All Satisfy
    func satisfyAll() {
        let publisher = [2, 4, 6, 8, 10, 12].publisher
        publisher
            .allSatisfy { $0 % 2 == 0 }
            .sink(receiveValue: { allEven in
                print(allEven ? "All numbers are even" : "Something is odd...")
            })
            .store(in: &subscriptions)
    }
    // Reduce
    func reduceCall() {
        let publisher = ["Hel", "lo", " ", "Wor","ld", "!"].publisher
        publisher
            .reduce("->") { accumulator, value in
                accumulator + value
            }
            .sink(receiveValue: { print("Reduced into: \($0)") })
            .store(in: &subscriptions)
    }
}
