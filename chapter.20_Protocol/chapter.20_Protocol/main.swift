//
//  main.swift
//  chapter.20_Protocol
//
//  Created by 장영우 on 2020/09/17.
//  Copyright © 2020 jangscon. All rights reserved.
//

import Foundation

//발신 프로토콜
protocol Sendable {
    var from : Sendable { get }
    var to : Receiveable? { get }
    
    func send(data : Any)
    
    static func inSandableInstance(_ instance : Any) -> Bool
}

//수신 프로토콜
protocol Receiveable {
    func received(data : Any , from : Sendable)
}

//메세지 클래스
class Message : Sendable , Receiveable {
    var from : Sendable {
        return self
    }
    
    var to : Receiveable?
    
    func send(data: Any) {
        guard let receiver : Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable) {
        print("Message received \(data) from \(from)")
    }
    
    class func inSandableInstance(_ instance: Any) -> Bool {
        if let sendableInstance : Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

//메일 클래스
class Mail : Sendable , Receiveable {
    var from : Sendable {
        return self
    }
    
    var to : Receiveable?
    
    func send(data: Any) {
        guard let receiver : Receiveable = self.to else {
            print("Mail has no receiver")
            return
        }
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable) {
        print("Mail received \(data) from \(from)")
    }
    
    static func inSandableInstance(_ instance: Any) -> Bool {
        if let sendableInstance : Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

//메세지 인스턴스 둘
let myphoneMessage : Message = Message()
let yourphoneMessage : Message = Message()

//수신받을 인스터스가 없음.
myphoneMessage.send(data: "Hello")

myphoneMessage.to = yourphoneMessage
myphoneMessage.send(data: "Hello")

let myMail : Mail = Mail()
let yourMail : Mail = Mail()

myMail.send(data: "Hi")

myMail.to = yourMail
myMail.send(data: "Hi")

myMail.to = yourphoneMessage
myMail.send(data: "Bye")

//String은 Sendable 프로토콜을 준수하지 않음
print("\"Hello\" is Sendable? = " ,Message.inSandableInstance("Hello"))
//myPhone은 Sendable 프로토콜을 준수하고 to 프로퍼티가 설정
print("myphoneMessage is Sendalbe? = " ,Message.inSandableInstance(myphoneMessage))
//yourphone은 Sendable 프로토콜을 준수하지만 to 프로퍼티가 설정되지 않음.
print("yourphoneMessage is Sendalbe? = " ,Message.inSandableInstance(yourphoneMessage),"\n\n")



//********************************************************************************
//프로토콜의 가변 메서드 요구


protocol Resettable {
    //인스턴스 내부의 값을 변경가능하게 하는 mutating 키워드
    mutating func reset()
}

class Person : Resettable {
    var name : String?
    var age : Int?
    
    //클래스는 뮤테이팅이 필요없다.
    func reset() {
        self.name = nil
        self.age = nil
    }
}

struct Point : Resettable {
    var x : Int = 0
    var y : Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction : Resettable {
    case east , west , south , north , unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}


//********************************************************************************
// 프로토콜의 이니셜라이저 요구

protocol Named {
    var name : String { get }
    
    //실패가능한 init
    init?(name : String)
}

struct Pet : Named {
    var name : String
    
    //무조건 구현해야 함.
    init(name : String) {
        self.name = name
    }
    
    //이 이니셜라이즈만 한다면 오류
    init() {
        self.name = "ERROR"
    }
}

class School {
    var name : String
    
    init(name : String) {
        self.name = name
    }
}

class MiddleSchool : School , Named {
    
    //named protocol 의 init은 required로 충족
    //조상 클래스인 School의 init은 override로 충족
    required override init(name: String) {
        super.init(name: name)
    }
}

struct Animal : Named {
    var name : String
    
    init!(name : String) {
        self.name = name
    }
}

class Person2 : Named {
    var name : String
    
    required init(name: String) {
        self.name = name
    }
}


//********************************************************************************
//프로토콜끼리의 상속 , 클래스 전용 프로토콜

protocol Readable {
    func read()
}

protocol Writeable {
    func write()
}

protocol ReadSpeakable : Readable {
    func speak()
}

//이렇게 프로토콜끼리 상속도 가능하다.
protocol ReadWriteSpeakable : Readable , Writeable {
    func speak()
}

class someClass : ReadWriteSpeakable {
    
    func read() {
        print("read")
    }
    
    func write() {
        print("write")
    }
    func speak(){
        print("speak")
    }
}

//상속 부분에 class를 추가하여 class만이 상속가능한 프로토콜이란것을 알려줌.
protocol ClassOnlyProtocol : class, Readable , Writeable {}

class SomeClass : ClassOnlyProtocol {
    func read() {}
    func write() {}
}

//ERROR : 구조체에 클래스 전용 프로토콜을 상속하여 오류가 생김.
/*
struct SomeStruct : ClassOnlyProtocol {
    func read() {}
    func write() {}
}
*/
