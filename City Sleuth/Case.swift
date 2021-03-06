//
//  Case.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import Foundation

class Case {
    
    var name : String
    
    var ID : Int
    
    var imageName: String
    
    var suspects : Array<Suspect>
    
    var locations : Array<Location>
    
    var date: String
    
    var victim: String
    
    var crime : String
    
    var briefingImage : String
    
    var startplace: String
    
    var location : String
    
    var evidence : Array<Evidence>
    
    var hints : Array<Hint>
    
    var currentHint : Hint? = nil
    
    var curHint = ""
    
    var quizes : Array<Quiz>
    
    var curLoc : Location?
    
    var curQuiz : Quiz?
    
    func getCurrentLocation() -> Location? {
        var curLoc : Location? = nil
        for i in  0...locations.count-1 {
            let ii = locations.count-1 - i
            curLoc = locations[ii]
            if (curLoc?.found)! {
                return curLoc
            }
        }
        return curLoc
    }
    
    func canDiscoverLocation(location : Location) -> Bool{
        if (location.found) {
            return false
        }
        if location === locations.first {
            return true
        }
        let loc = curLoc != nil ? curLoc! : getCurrentLocation()
        return (loc?.found)! && (loc?.unlocks)!.contains(location.id)
    }
    
    func discoveredLocation(location : Location) {
        curLoc = location
        location.found = true
        let newE = location.evidence
        let newH = location.hints
        let newS = location.suspects
        for e in evidence {
            if newE.contains(e.id) {
                e.discovered = true
            }
        }
        
        for h in hints {
            if newH.contains(h.id) {
                currentHint = h
                break
            }
        }
        
        for s in suspects {
            if newS.contains(s.id) {
                s.discovered = true
            }
        }
        
        curQuiz = curLoc?.quiz
        
    }
    
    init(caseName: String, caseID: Int, imgName: String, suspects: Array<Suspect>, date: String, victim: String, crime: String, briefImage: String, startName: String, location: String, locations : Array<Location>, evidence : Array<Evidence>, hints: Array<Hint>, quizes : Array<Quiz>) {
        name = caseName
        ID = caseID
        imageName = imgName
        self.suspects = suspects
        self.victim = victim
        self.crime = crime
        self.date = date
        self.briefingImage = briefImage
        startplace = startName
        self.location = location
        self.locations = locations
        self.evidence = evidence
        self.hints = hints
        self.quizes = quizes
    }
    
}
