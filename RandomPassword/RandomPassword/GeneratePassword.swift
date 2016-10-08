//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by 马志彬 on 16/10/5.
//  Copyright © 2016年 马志彬. All rights reserved.
//

import Foundation

private let characters = Array("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".characters)

func generateRandomCharacter() -> Character {
    let index = Int(arc4random_uniform(UInt32(characters.count)))
    return characters[index]
}

func generateRandomString(length: Int) -> String {
    var string = ""
    for _ in 0..<length {
        string.append(generateRandomCharacter())
    }
    return string
}
