//
//  Employee.swift
//  RaiseMan
//
//  Created by 马志彬 on 16/10/23.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Foundation

class Employee: NSObject, NSCoding {
    dynamic var name = "New Employee"
    dynamic var raise: Float = 0.05
    
    override public init(){
        super.init()
    }

    public required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        raise = aDecoder.decodeFloat(forKey: "raise")
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: "name")
        aCoder.encode(raise,forKey: "raise")
    }
    
    override func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKeyPath inKeyPath: String) throws {
        let raiseNumber = ioValue.pointee
        if raiseNumber == nil {
        let domain = "UserInputValidationErrorDomain"
            let code = 0
            let userInfo = [NSLocalizedDescriptionKey: "An employee raise must be a number."]
            throw NSError(domain: domain, code: code, userInfo: userInfo)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        Swift.print("Employee forUndefinedKey \(key)")
    }

    public func say(){
        print("Employee")
    }
}
