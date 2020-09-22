//
//  main.swift
//  Generic_2
//
//  Created by 장영우 on 2020/09/22.
//

import Foundation

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

//제네릭을 사용하는 구조체에서 익스텐션사용
extension Stack {
    var topElement : Element? {
        return self.items.last
    }
}
var stack : Stack<Double> = Stack<Double>()
stack.push(12.12)
print(stack.topElement!)

//타입 제약
//오직 크래스,프로토콜로만 줄 수 있다.

//BinaryInteger = protocol :: 프로토콜로 제네릭의 타입 제한
func swapTwoValues <T : BinaryInteger> ( _ a : inout T , _ b : inout T) {}

func swapTwovalues2 <T : BinaryInteger> ( _ a : inout T , _ b : inout T) where T :
    FloatingPoint { }

//이 함수는 성립할수 없다.  사용하려면 generic T 를 뺄셈 연사자를 사용할 수 있는 타입으로 한정시켜주면 된다.
//Referencing operator function '-' on 'FloatingPoint' requires that 'T' conform to 'FloatingPoint'
/*
func subtractTwovalues <T> (_ a : T , _ b : T) -> T {
    return a - b
}
*/

//이렇게 제네릭을 BinaryInteger로 한정 시키면 뺄셈연산자를 사용이 가능하다.
func subtractTwovallues <T : BinaryInteger> ( _ a : T , _ b : T) -> T {
    return a - b
}

print("3 - 9 = " , subtractTwovallues(3, 9))


//프로토콜의 연산
protocol Container {
    //associatedtype (연관타입) == 프로토콜에 어떤 타입이 쓰일지 모르지만 어떠한 타입이 쓰일것이다 라고 알려줌.
    associatedtype ItemType
    var count : Int {get}
    mutating func append(_ item : ItemType)
    subscript(i : Int) -> ItemType {get}
}

class MyContainer : Container {
    var items : Array<Int> = Array<Int>()
    
    var count : Int {
        return items.count
    }
    func append(_ item: Int) {
        items.append(item)
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
var mycontainer : MyContainer = MyContainer()
print(mycontainer.count)
mycontainer.append(12)
mycontainer.append(13)
mycontainer.append(14)
print(mycontainer.count)
for i in 0..<mycontainer.count {
    print(mycontainer[i]," ", terminator : "")
}

struct IntStack :  Container {
    var items : [Int] = [Int]()
    mutating func push (_ item : Int) {
        items.append(item)
    }
    mutating func pop () -> Int {
        return items.removeLast()
    }
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count : Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

