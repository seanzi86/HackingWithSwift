import UIKit

extension Int {
    func plusOne() -> Int {
        return self + 1
    }

    mutating func mutatingPlusOne() {
        self += 1
    }
}

extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}

extension String {
    mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

var myInt = 0
myInt.plusOne()
5.plusOne()

var mySecondInt = 10
mySecondInt.plusOne()
mySecondInt


var myThirdInt = 10
myThirdInt.mutatingPlusOne()
myThirdInt

let i: Int = 8
print(i.squared())

let j: UInt64 = 8
print(j.squared())
