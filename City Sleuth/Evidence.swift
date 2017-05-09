//
//  Evidence.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import Foundation

class Evidence {
    
    static let TYPE_AUDIO = "audio"
    static let TYPE_VIDEO = "video"
    static let TYPE_TEXT = "text"
    static let TYPE_PICTURE = "picture"
    static let TYPE_WEB = "web"
    static let TYPE_UNKNOWN = "unknown"
    
    var name : String
    
    var id : Int
    
    var description : String
    
    var filename : String
    
    var type : String
    
    var discoveredAt : String
    
    var discovered  = false
    
    init(name : String, id: Int, desc : String, filename: String, type: String, discoveredAt : String) {
        self.name = name
        self.description = desc
        self.filename = filename
        self.discoveredAt = discoveredAt
        self.type = type
        self.id = id
        if type != Evidence.TYPE_AUDIO && type != Evidence.TYPE_VIDEO && type != Evidence.TYPE_TEXT && type != Evidence.TYPE_PICTURE && type != Evidence.TYPE_WEB {
            self.type = Evidence.TYPE_UNKNOWN
        }
    }
    
}
