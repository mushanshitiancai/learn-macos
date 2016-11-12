//
//  CarArrayController.swift
//  CarLot
//
//  Created by 马志彬 on 16/11/6.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController{
    override func newObject() -> Any {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        newObj.setValue(now, forKey: "datePurchased")
        return newObj
    }
}


