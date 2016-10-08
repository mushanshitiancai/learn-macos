//
//  AppDelegate.swift
//  RandomPassword
//
//  Created by 马志彬 on 16/10/5.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindowController = MainWindowController()
        mainWindowController?.showWindow(self)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

