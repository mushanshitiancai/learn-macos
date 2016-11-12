//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by 马志彬 on 16/10/15.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate{
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    @IBOutlet weak var tableView: NSTableView!
    
    let preferenceManager = PreferenceManager()
    var speakSynth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices()
    
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
        
        for voice in voices {
            print(voiceName(identifier: voice))
        }
        
        let defaultVoice = preferenceManager.activeVoice!
        if let defaultRow = voices.index(of: defaultVoice) {
            let indices = IndexSet(integer: defaultRow)
            tableView.selectRowIndexes(indices, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }
        textField.stringValue = preferenceManager.activeText!
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
    
    func voiceName(identifier: String) -> String? {
        if let name = NSSpeechSynthesizer.attributes(forVoice: identifier)[NSVoiceName] as? String {
            return name
        } else {
            return nil
        }
    }
    
    // MARK: - NSSpeechSynthesizerDelegate
    
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("didFinishSpeaking \(finishedSpeaking)")
    }
    
    // MARK: - NSWindowDelegate
    
    func windowShouldClose(_ sender: Any) -> Bool {
        return !isStarted
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return voiceName(identifier: voices[row])
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        print("tableViewSelectionDidChange \(row)")
        
        if row == -1 {
            speakSynth.setVoice(nil)
            preferenceManager.activeVoice = nil
        } else {
            speakSynth.setVoice(voices[row])
            preferenceManager.activeVoice = voices[row]
        }
    }
    
    // MARK: - NSTextFieldDelegate
    
    override func controlTextDidChange(_ obj: Notification) {
        preferenceManager.activeText = textField.stringValue
    }
}
