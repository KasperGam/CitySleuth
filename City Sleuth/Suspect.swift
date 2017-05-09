//
//  Suspect.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/6/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import Foundation

class Suspect {
    
    var name : String
    
    var age : Int
    
    var id : Int
    
    var sex : String
    
    var image : String
    
    var occupaiton: String
    
    var alibi : String
    
    var testimony : String
    
    var relation : String
    
    var discovered = false
    
    init(sName: String, sAge: Int, sID: Int, sOcc: String, sAlibi: String, sTestimony: String, sRelation: String, sSex: String, sImage : String) {
        name = sName
        age = sAge
        occupaiton = sOcc
        alibi = sAlibi
        testimony = sTestimony
        relation = sRelation
        sex = sSex
        id = sID
        image = sImage
    }
    
}
