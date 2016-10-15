//
//  MainWindowController.swift
//  RGBWell
//
//  Created by 马志彬 on 16/10/10.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var rSlider: NSSlider!
    @IBOutlet weak var gSlider: NSSlider!
    @IBOutlet weak var bSlider: NSSlider!
    
    var r = 0.2
    var g = 0.4
    var b = 0.6
    let a = 1.0
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        rSlider.action = #selector(adjustRed(sender:))
        //#selector(MainWindowController.adjustRed(sender:))
        rSlider.doubleValue = r
        gSlider.doubleValue = g
        bSlider.doubleValue = b
        updateColor()
    }
    
    @IBAction func adjustRed(sender:NSSlider) {
        print("R slider's value is \(sender.floatValue)")
        r = sender.doubleValue
        updateColor()
    }
    
    @IBAction func adjustGreen(sender:NSSlider){
        print("G slider's value is \(sender.floatValue)")
        g = sender.doubleValue
        updateColor()
    }
    
    @IBAction func adjustBlue(sender:NSSlider){
        print("B slider's value is \(sender.floatValue)")
        b = sender.doubleValue
        updateColor()
    }
    
    func updateColor(){
        let newColor = NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        
        colorWell.color = newColor
    }
}
