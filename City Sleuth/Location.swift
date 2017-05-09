//
//  Location.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import Foundation

class Location {
    
    var address : String
    
    var id : Int
    
    var lat : Double
    
    var long : Double
    
    var startText : String
    
    var afterText : String
    
    var name : String
    
    var unlocks : Array<Int>
    
    var suspects : Array<Int>
    
    var evidence : Array<Int>
    
    var hints : Array<Int>
    
    var backgroundImg : String
    
    var found = false
    
    init(name: String, address : String, id: Int, latitude : Double, longitude: Double, startTxt : String, aftText : String, unlocks: Array<Int>, suspects: Array<Int>, evidence : Array<Int>, background : String, hints: Array<Int>) {
        self.address = address
        self.id = id
        self.lat = latitude
        self.long = longitude
        self.startText = startTxt
        self.afterText = aftText
        self.name = name
        self.unlocks = unlocks
        self.suspects = suspects
        self.evidence = evidence
        self.backgroundImg = background
        self.hints = hints
    }
    
}
