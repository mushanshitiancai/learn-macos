//
//  MainWindowController.swift
//  RandomPassword
//
//  Created by 马志彬 on 16/10/5.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var textField: NSTextField!
    
    override var windowNibName: String?{
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func generatePassword(sender: AnyObject){
        let password = generateRandomString(length: 8)
        textField.stringValue = password
    }
}
