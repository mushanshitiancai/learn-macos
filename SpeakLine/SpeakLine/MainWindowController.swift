//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by 马志彬 on 16/10/15.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate{
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    var speakSynth = NSSpeechSynthesizer()
    
    var isStarted: Bool = false {
        didSet {
            updateButton()
        }
    }
    
    override var windowNibName: String?{
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        speakSynth.delegate = self
        updateButton()
    }
    
    // MARK: - Action Method
    
    @IBAction func speakIt(sender: NSButton){
        let string = textField.stringValue
        if string.isEmpty {
            print("string from \(textField) is empty")
        }else {
            print("string is \"\(textField.stringValue)\"")
            speakSynth.startSpeaking(string)
            isStarted = true
        }
    }
    
    @IBAction func stopIt(sender: NSButton){
        speakSynth.stopSpeaking()
        print("stop")
    }
    
    func updateButton(){
        if isStarted {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            speakButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    
    // MARK: - NSSpeechSynthesizerDelegate
    
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("didFinishSpeaking \(finishedSpeaking)")
    }
    
    //MARK: - NSWindowDelegate
    
    func windowShouldClose(_ sender: Any) -> Bool {
        return !isStarted
    }
}
