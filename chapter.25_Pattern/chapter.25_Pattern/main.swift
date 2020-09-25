//
//  main.swift
//  chapter.25_Pattern
//
//  Created by 장영우 on 2020/09/25.
//

import Foundation

// - 값을 해제(추출)하거나 무시하는 패턴 :
//   와일드카드 패턴 , 식별자 패턴 , 값 바인딩 패턴 , 튜플 패턴
// - 패턴 매칭을 위한 패턴 :
//   열거형 케이스 , 옵셔널 패턴 , 표현 패턴 , 타입캐스팅 패턴

//***********************************************************
//와일드카드 패턴
let string : String = "ABC"

switch string{
// '_' = 어떤 값이든 상관없이 실행
case _ : print(string)
}
// output : ABC

let optionalString : String? = "ABC"

switch optionalString {
case "ABC"? : print(optionalString)
//"ABC"? 외에 값이 있을때만 가능. nil도 안됌.
case _? : print("Has value, but not ABC")
case nil : print("nil")
}
// output : Optional("ABC")

let man = ("tom" , 99 , "Male")

switch man {
//man의 첫번째 요소가 tom이면 다른요소들은 상관없음.
case ("tom",_,_):
    print("Hello Tom!!")
//모든 요소들이 무엇이든지 상관없음.
case (_,_,_):
    print("who cares~")
}
//ouput : Hello Tom!!

//그저 2번만 실행되는 for문
for _ in 0..<2 {
    print("Hello")
}
//output : Hello
//         Hello

//***********************************************************
//값 바인딩 패턴

//let man = ("tom" , 99 , "Male")
switch man {
    //name , age , gender 를 man의 각각의 요소와 바인딩
    case (let name , let age , let gender) :
        print("Name : \(name) , Age : \(age) , Gender : \(gender)")
}
//output : Name : tom , Age : 99 , Gender : Male

switch man {
//깂 바인딩 패턴과 와일드카드 패턴의 결합
case (let name , _ , let gender) :
    print("Name : \(name) , Gender : \(gender)")
}
//output : Name : tom , Gender : Male

//***********************************************************
//튜플 패턴

let (a) : Int = 2
print(a)

let (x , y) : (Int , Int) = (1, 2)
print(x)

let points : [(Int , Int)] = [(0,0),(1,0),(1,1),(2,0),(2,1)]
print("Points")
for (x,_) in points {
    print(x)
}

//***********************************************************
//열거형 케이스 패턴

let someValue : Int = 30

if case 0...100 = someValue {
    print("0 <= \(someValue) <= 100")
}

let anotherValue : String = "ABC"

if case "ABC" = anotherValue {
    print(anotherValue)
}

enum MainDish {
    case pasta(taste : String)
    case pizza(dough : String , topping : String)
    case chicken(withSauce : Bool)
    case rice
}

var dishes : [MainDish] = []
var dinner : MainDish = .pasta(taste: "Cream")
dishes.append(dinner)

if case .pasta(let taste) = dinner{
    print("\(taste) pasta")
}

dinner = .pizza(dough: "cheeze crust", topping: "Bulgogi")
dishes.append(dinner)

func whatIsthis (dish : MainDish) {
    guard case .pizza(let dough , let topping) = dinner else {
        print("It's not a pizza")
        return
    }
    
    print("\(dough) \(topping) pizza")
}
whatIsthis(dish: dinner)

dinner = .chicken(withSauce: true)
dishes.append(dinner)

while case .chicken(let Sauce) = dinner {
    print("\(Sauce ? "양념" : "후라이드") 통닭")
    break
}
dinner = .rice
dishes.append(dinner)

if case .rice = dinner {
    print("today's meal is rice!")
}

for dish in dishes {
    switch dish {
    case let .pasta(taste): print(taste)
    case let .chicken(Sauce) : print(Sauce ? "양념" : "후라이드")
    case let .pizza(dough, topping) : print(dough , topping)
    case let .rice : print("Just rice")
    }
}

