//
//  main.swift
//  chapter.23_POP(protocol oriented programming)
//
//  Created by 장영우 on 2020/09/23.
//

import Foundation

protocol SelfPrintable {
    func printself()
}

extension SelfPrintable where Self : Container {
    func printself(){
        print(items)
    }
}
protocol Container : SelfPrintable {
    associatedtype ItemType
    
    var items : [ItemType] {get set}
    var count : Int {get}
    
    mutating func append(item : ItemType)
    subscript(i : Int) -> ItemType {get}
}

extension Container {
    mutating func append(item : ItemType) {
        items.append(item)
    }
    var count : Int {
        return items.count
    }
    subscript (i : Int) -> ItemType {
        return items[i]
    }
}

protocol Popable : Container {
    mutating func pop() -> ItemType?
    mutating func push(_ item : ItemType)
}

extension Popable {
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }
    
    mutating func push(_ item : ItemType) {
        self.append(item: item)
    }
}

protocol Insertable : Container {
    mutating func delete() -> ItemType?
    mutating func insert(_ item : ItemType)
}

extension Insertable {
    mutating func delete() -> ItemType? {
        return items.removeLast()
    }
    mutating func insert( _ item : ItemType) {
        self.append(item: item)
    }
}

struct Stack<Element> : Popable {
    var items : [Element] = [Element]()
    
    //stack 구조체의 map 메서드
    func map<T> (transform : (Element) -> T) -> Stack<T> {
        var transformedStack : Stack<T> = Stack<T>()
        for item in items {
            transformedStack.items.append(transform(item))
        }
        return transformedStack
    }
    
    //stack 구조체의 filter 메서드
    func filter (includeElement : (Element) -> Bool) -> Stack<Element>  {
        var filterStack : Stack<Element> = Stack<Element>()
        
        for item in items {
            if includeElement(item) {
                filterStack.items.append(item)
            }
        }
        return filterStack
    }
    
    //reduce 메서드
    func reduce<T> (_ initialresult : T , nextPartialResult : (T , Element) -> T) -> T {
        var result : T = initialresult
        
        for item in items {
            result = nextPartialResult(result , item)
        }
        
        return result
    }
    
    
    
}
struct Queue<Element> : Insertable {
    var items : [Element] = [Element]()
}


var myIntStack : Stack<Int> = Stack<Int>()
var myStringStack : Stack<String> = Stack<String>()
var myIntQueue : Queue<Int> = Queue<Int>()
var myStringQueue : Queue<String> = Queue<String>()

myIntStack.push(3)
myIntStack.push(2)

myIntStack.printself()

myIntStack.pop()
myIntStack.printself()

myStringStack.push("A")
myStringStack.printself()
myStringStack.push("B")
myStringStack.printself()

myStringStack.pop()
myStringStack.printself()

myIntQueue.insert(1)
myIntQueue.insert(2)
myIntQueue.printself()

myStringQueue.insert("C")
myStringQueue.insert("D")
myStringQueue.printself()

myStringQueue.delete()
myStringQueue.printself()

//Array 타입의 맵 사용
let items : Array<Int> = [1,2,3]

let mappedItems : Array<Int> = items.map { (item : Int) -> Int in
    return item * 10
}
//[10,20,30]
print(mappedItems)

var myIntStack2 : Stack<Int> = Stack<Int>()
myIntStack2.push(1)
myIntStack2.push(5)
myIntStack2.push(2)
myIntStack2.printself()

//map 함수로 스택을 Int 에서 String 타입으로 바꿈.
var myStrStack : Stack<String> = myIntStack2.map(transform: {(Int) -> String in   return "\(Int)"})
//Stack<Int> 타입을 Stack<String>타입으로 바꿈.
myStrStack.printself()

//스택에서 filter 메서드 사용도 가능.
let filteredStack : Stack<Int> = myIntStack2.filter {$0 < 5}
//스택안의 아이템 중 5보다 작은 수만을 필터링해서 filteredStack.items가 가지는 값은 1 ,2 이다.
filteredStack.printself()

//myIntStack2라는 스택에서 reduce를 사용하여 Int값을 return
let combinedInt : Int = myIntStack2.reduce(100) { (result : Int , next : Int) -> Int in
    return result + next
}
//100(초기값) + 1 + 5 + 2 = 108
print(combinedInt)

let combinedDouble : Double = myIntStack2.reduce(100.0) {(result : Double , next : Int) -> Double in
    return result + Double(next)
}
//combinedInt의 Double type version : 108.0
print(combinedDouble)

let combinedString : String =  myIntStack2.reduce("") {(result : String , next : Int) -> String in
    return result + "\(next) "
}
//myIntStack2 의 [1,5,2]를 문자열로 합침 = "1 5 2 "
print(combinedString)


//기본 확장 타입

//기본 타입에도 프로토콜의 초기 구현으로 익스텐션할 수 있다.
extension Int : SelfPrintable {
    func printself() {
        print(self)
    }
}
extension String : SelfPrintable {
    func printself() {
        print(self)
    }
}
extension Double : SelfPrintable {
    func printself() {
        print(self)
    }
}

1024.printself()
3.14.printself()
"hana".printself()


