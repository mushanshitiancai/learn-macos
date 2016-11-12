//
//  MainWindowController.swift
//  Thermostat
//
//  Created by 马志彬 on 16/10/20.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
//    dynamic var temprature = 68
    private var privateTemprature = 68
    dynamic var temprature: Int {
        set {
            privateTemprature = newValue
            print("set temprature \(newValue)")
        }
        get {
            print("get temprature \(privateTemprature)")
            return privateTemprature
        }
    }
    dynamic var isOn = true
    
    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func makeWarmer(_ sender: AnyObject) {
//        let newTemprature = temprature + 1
//        setValue(newTemprature, forKey: "temprature")
//        willChangeValue(forKey: "temprature")
        temprature += 1
//        didChangeValue(forKey: "temprature")
    }
    
    @IBAction func makeCooler(_ sender: AnyObject) {
//        let newTemprature = temprature - 1
//        setValue(newTemprature, forKey: "temprature")
//        willChangeValue(forKey: "temprature")
        temprature -= 1
//        didChangeValue(forKey: "temprature")
    }
}
