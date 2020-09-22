//
//  main.swift
//  chapter.22_Generic
//
//  Created by 장영우 on 2020/09/22.
//

import Foundation

prefix operator **
//제네릭 사용하여 BinaryIntegar 프로토콜인 타입들은 모두 사용할 수 있다.
prefix func ** <T : BinaryInteger>(value : T) -> T {
    return value * value
}

let minusFive : Int = -5
let five : UInt = 5

let sqrtMinusFive : Int = **minusFive
let sqrtFive : UInt = **five

print(sqrtFive , sqrtMinusFive)

func swapTwoInts(_ a : inout Int , _ b : inout Int) {
    let temporaryA : Int = a
    a = b
    b = temporaryA
}

var swapA : Int = 10
var swapB : Int = 20
print("swapA : \(swapA) , swapB : \(swapB)")
swapTwoInts(&swapA, &swapB)
print("after swapTwoInts(swapA, swapB)")
print("swapA : \(swapA) , swapB : \(swapB)")

//그러면 any를 쓰면 편하지 않나?
func swapTwoValues_any (_ a : inout Any , _ b : inout Any) {
    let temporaryA : Any = a
    a = b
    b = temporaryA
}
var anyone : Any = 1
var anytwo : Any = "two"

print("anyone : \(anyone) , amytwo : \(anytwo)")
swapTwoValues_any(&anyone, &anytwo)
print("anyone : \(anyone) , amytwo : \(anytwo)")

var string1 : String = "Hi"
var string2 : String = "Hello"

//Any를 파라미터로 가지면 Int,Double,String 등 ... 여러 타입을
//쓸수있는게 아닌 말 그대로 "Any"타입만 쓸 수 있다.
//swapTwoValues_any(&string1, &string2)

//제네릭을 사용한 스압함수
func swapTwoValues<T>(_ a : inout T , _ b : inout T) {
    let temporaryA : T = a
    a = b
    b = temporaryA
}

//이렇게 서로 타입만 같다면 모든 타입에서 실행할 수 있다.
swapTwoValues(&string1, &string2)
swapTwoValues(&swapA,&swapB )
swapTwoValues(&anyone, &anytwo)

//이렇게 타입이 다르다면 스왑이 불가
//swapTwoValues(&string1, &swapA)

struct Stack<Element> {
    var items : [Element] = [Element]()
    mutating func push (_ item : Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    func printStack () {
        for i in 0 ..< items.count {
            print(items[i] , " " ,terminator : "")
        }
        print()
    }
}

var doubleStack : Stack<Double> = Stack<Double>()
doubleStack.push(1.0)
doubleStack.push(2.0)
doubleStack.push(3.0)
doubleStack.push(4.44)
doubleStack.printStack()

print(doubleStack.pop())
doubleStack.printStack()


