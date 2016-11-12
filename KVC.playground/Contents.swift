//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

class Student: NSObject {
    var name = ""
    var gradeLevel = 0
}

let s = Student()
s.setValue("name", forKey: "name")
s.setValue(10, forKey: "gradeLevel")
s.name
s.gradeLevel
s.value(forKey: "name")
s.value(forKey: "gradeLevel")

class Address: NSObject {
    var firstLine: String
    var secondLine: String
    
    init(firstLine: String, secondLine: String) {
        self.firstLine = firstLine
        self.secondLine = secondLine
    }
}

class Person: NSObject{
    dynamic var firstName: String
    var lastName: String
    var address: Address
    var friends: NSMutableArray
    dynamic var friends2: [Person]
    
    init(firstName:String,lastName:String,address:Address) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.friends = NSMutableArray()
        self.friends2 = []
    }
    
    convenience init(firstName:String,lastName:String) {
        self.init(firstName: firstName,lastName: lastName,address: Address(firstLine: "Beijing", secondLine: "Haidian"))
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        return "not exists"
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("peter: keyPath=\(keyPath) object=\(object) change=\(change) context=\(context)")
    }
    
}

let peter = Person(firstName: "Cook", lastName: "Peter", address: Address(firstLine: "Beijing", secondLine: "Haidian"))
peter.firstName
peter.value(forKey: "lastName")
peter.value(forKeyPath: "lastName")
peter.value(forKey: "non")

peter.address
peter.value(forKey: "address")

let a = peter.value(forKey: "address") as! Address
a.firstLine

peter.value(forKeyPath: "address.firstLine")

peter.setValue("Fuzhou", forKeyPath: "address.firstLine")
peter.address.firstLine

peter.friends.add(Person(firstName: "1", lastName: "1"))
peter.friends
peter.mutableArrayValue(forKey: "friends").count

peter.friends2.append(Person(firstName: "2", lastName: "2"))
peter.friends2
peter.mutableArrayValue(forKey: "friends2").count
peter.mutableArrayValue(forKey: "friends2")[0]

var context = 0
var context2 = 0
class MyObserver0: NSObject{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("keyPath=\(keyPath) object=\(object) change=\(change) context=\(context)")
    }
}

var myObserver = MyObserver0()

peter.firstName
peter.addObserver(myObserver, forKeyPath: "firstName", options: .old, context: &context)
peter.addObserver(peter, forKeyPath: "firstName", options: .new, context: &context)
peter.addObserver(peter, forKeyPath: "firstName", options: .old, context: &context2)
peter.firstName = "fuck"
peter.friends2.append(Person(firstName: "3", lastName: "3"))




class MyObjectToObserve: NSObject {
    dynamic var myDate = NSDate()
    func updateDate() {
        myDate = NSDate()
    }
}

private var myContext = 0

class MyObserver: NSObject {
    var objectToObserve = MyObjectToObserve()
    override init() {
        super.init()
        objectToObserve.addObserver(self, forKeyPath: "myDate", options: .new, context: &myContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext {
            if let newValue = change?[NSKeyValueChangeKey.newKey] {
                print("Date changed: \(newValue)")
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }

    }
    
    
    deinit {
        objectToObserve.removeObserver(self, forKeyPath: "myDate", context: &myContext)
    }
}

var m = MyObserver()
m.objectToObserve.updateDate()
