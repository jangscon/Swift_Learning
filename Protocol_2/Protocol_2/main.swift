//
//  main.swift
//  Protocol_2
//
//  Created by 장영우 on 2020/09/19.
//

//프로토콜의 조합

import Foundation

protocol Named {
    var name : String {get}
}

protocol Aged {
    var age : Int {get}
}

struct Person : Named , Aged {
    var name : String
    var age : Int
    
    init(name : String , age : Int) {
        self.name = name
        self.age = age
    }
}

class Car : Named {
    var name : String
    init(name : String) {
        self.name = name
    }
}

class Truck : Car ,Aged {
    var age : Int
    
    init(name : String , age : Int) {
        self.age = age
        super.init(name: name)
    }
}

//celebrator란 변수는 Named 와 Aged 프로토콜 둘 다 요구됨
func celebrateBirthday(to celebrator : Named & Aged) {
    print("Happy Birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let yagom : Person = Person(name: "yagom", age: 99)
//Person 클래스는 Named 와 Aged 프로토콜 둘 다 준수함으로 celebrateBirthday 함수의 파라미터로 사용가능.
celebrateBirthday(to: yagom)

let myCar : Car = Car(name: "Boong Boong")
//오류발생! myCar 는 Car 클래스로 Named 프로토콜만을 준수함.
//celebrateBirthday(to: myCar)

//클래스타입은 한 타입만이 조합가능! , Car 와 Truck , 이 두 프로토콜이 문제
//var someVariable : Car & Truck & Aged

var somevariable : Car & Aged

//Truck은 Car 클래스의 역할도 Aged 프로토콜도 준수함.
somevariable = Truck(name: "Truck", age: 12)

print(yagom is Named)
print(yagom is Aged)

print(myCar is Named)
print(myCar is Aged)

//yagom : Person 이 Named 프로토콜을 내포함으로 if문은 true
if let castedInstance : Named = yagom as? Named {
    print("\(castedInstance) is Named")
}

if let castedInstance : Aged = yagom as? Aged {
    print("\(castedInstance) is Aged")
}

if let castedInstance : Named = myCar as? Named {
    print("\(castedInstance) is Named")
}
//캐스팅 실패
if let castedInstance : Aged = myCar as? Aged {
    print("\(castedInstance) is Aged")
}
print("\n\n")

//********************************************************************
//프로토콜의 선택적 요구

@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

class Tiger : NSObject , Moveable {
    func walk () {
        print("Tiger walk...")
    }
}

class Bird : NSObject ,Moveable {
    func walk() {
        print("Bird Walk...")
    }
    
    func fly() {
        print("Bird Fly!")
    }
}
let tiger : Tiger = Tiger()
let bird : Bird = Bird()

tiger.walk()
bird.walk()
bird.fly()

var moveableInstance : Moveable = tiger
moveableInstance.fly?() //응답없음
moveableInstance = bird
moveableInstance.fly?()

//********************************************************************
//프로토콜변수와 상수

protocol Fish {
    var name : String { get }
}

protocol fin {
    var length : Int { get }
}

class catfish : Fish {
    var name : String
    
    init(name : String) {
        self.name = name
    }
}

class goldfish : Fish {
    var name : String
    
    init(name : String) {
        self.name = name
    }
}

class shark : Fish , fin {
    var name : String
    var length: Int
    
    init(name : String , length : Int) {
        self.name = name
        self.length = length
    }
}

//이렇게 프로토콜을 타입으로 가지는 변수를 생성할 수 있다.
var someFish : Fish = catfish(name: "메기")
var someFish2 : Fish = shark(name: "상어", length: 20)

print(type(of: someFish2))
