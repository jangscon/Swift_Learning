//
//  main.swift
//  chapter.21_Extension
//
//  Created by 장영우 on 2020/09/20.
//

import Foundation

//연산프로퍼티의 추가

//익스텐션을 이용하여 Int타입에 연산프로퍼티를 추가
extension Int {
    var isEven : Bool {
        return self % 2 == 0
    }
    var isOdd : Bool {
        return self % 2 == 1
    }
}

//이렇게 추가되어 사용가능
print("1 is Odd : \(1.isOdd)")
print("1 is Even : \(1.isEven)")
print("\n")


//메서드의 추가

extension Int {
    //Int 타입에 메세드를 추가가능
    func multiply(by n : Int) -> Int {
        return self * n
    }
    
    //뮤테이팅 사용으로 내부값을 직접적으로 변경가능
    mutating func multiplyself (by n : Int) {
        self = self * n
    }
    
    static func isIntTypeInstance(_ instance : Any) {
        print( instance is Int )
    }
}

//3 * 2 = 6
print("3.multiply(by: 2) =",3.multiply(by: 2))
//4 * 5 = 20
print("4.multiply(by: 5) =",4.multiply(by: 5))

var num : Int = 4

//multiplyself메서드를 이용하여 자기자신에 3을 곱한 값으로 변경
num.multiplyself(by: 3)

print("num(4).multiplyself(by: 3) =",num)

//isIntTypeInstance는 static으로 따로 인스턴스를 생성하지 않고도 사용가능
Int.isIntTypeInstance("3")
Int.isIntTypeInstance(3)
Int.isIntTypeInstance(num)

prefix operator ++

struct Position {
    var x : Int
    var y : Int
}

extension Position {
    static func + (left : Position , right : Position) -> Position {
        return Position(x : left.x + right.x , y : left.y + right.y)
    }
    static prefix func - (vector : Position) -> Position {
        return Position(x: -vector.x, y: -vector.y)
    }
    static func += (left : inout Position , right : Position) {
        left = left + right
    }
}

extension Position {
    static func == (left : Position , right : Position) -> Bool  {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left : Position , right : Position) -> Bool {
        return !(left == right)
    }
}
extension Position {
    static prefix func ++ (position : inout Position) -> Position {
        position.x += 1
        position.y += 1
        return position
    }
}
var myPosition : Position  = Position(x: 10, y: 10)
var yourPosition : Position = Position(x: -5, y: -5)

print(myPosition + yourPosition)
print(-myPosition)

myPosition += yourPosition
print(myPosition)
print(++myPosition)


//이니셜라이즈 또한 익스텐션을 이용해서 추가할 수 있다.
extension String {
    init(intTypeNumber : Int){
        self = "\(intTypeNumber)"
    }
    init(doubleTypeNumber : Double) {
        self = "\(doubleTypeNumber)"
    }
}
var stringFromInt : String = String(intTypeNumber: 10)
var stringFromDouble : String = String(doubleTypeNumber: 11.03)
print(stringFromInt , stringFromDouble)

class Person {
    var name : String
    
    init(name : String) {
        self.name = name
    }
}

extension Person {
    convenience init() {
        self.init(name : "Unknown")
    }
}
let somePerson : Person = Person()
print(somePerson.name)

//서브스크립트도 익스텐션으로 추가가능

extension String {
    subscript(appendValue : String) -> String {
        return self + appendValue
    }
    subscript(repeatCount : UInt) -> String {
        var str : String = ""
        
        for _ in 0..<repeatCount {
            str += self
        }
        return str
    }
}
print("abc"["def"])
print("abcd"[3])


//중첩 데이터 타입 추가
extension Int {
    //Int 타입에 enum타입의 kind를 익스텐션으로 추가
    enum Kind {
        case negative , zero , positive
    }
    
    //연산프로퍼티
    var kind : Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0 :
            return .positive
        default:
            return .negative
        }
    }
}

print(1.kind)
print(0.kind)

func printIntegerKinds(numbers : [Int]) {
    for number in numbers {
        switch number.kind {
        case .zero:
            print("0 ", terminator: "")
        case .positive :
            print("+ ", terminator : "")
        default:
            print("- " , terminator : "")
        }
    }
    print("")
}
printIntegerKinds(numbers: [3,19,-27 , 0 , -6 , 0 , 7])
