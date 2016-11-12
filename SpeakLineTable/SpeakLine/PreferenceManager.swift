//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by 马志彬 on 16/11/8.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"

class PreferenceManager {
    private let userDefaults = UserDefaults.standard
    
    var activeVoice: String? {
        get {
            return userDefaults.object(forKey: activeVoiceKey) as? String
        }
        set {
            userDefaults.setValue(newValue, forKey: activeVoiceKey)
        }
    }
    
    var activeText: String? {
        get {
            return userDefaults.object(forKey: activeTextKey) as? String
        }
        set {
            userDefaults.setValue(newValue, forKey: activeTextKey)
        }
    }
    
    init(){
        registerDefaultPreference()
    }
    
    func registerDefaultPreference(){
        let defaults = [
            activeVoiceKey: NSSpeechSynthesizer.defaultVoice(),
            activeTextKey: "Able was I ere I saw Elba."
        ]
        
        userDefaults.register(defaults: defaults)
    }
}
