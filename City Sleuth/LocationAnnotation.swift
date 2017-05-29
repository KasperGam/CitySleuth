//
//  LocationAnnotation.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import MapKit

class LocationAnnotation : NSObject, MKAnnotation {
    
    var location : Location
    
    let coordinate: CLLocationCoordinate2D

    
    init(location : Location) {
        self.location = location
        self.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
        
        super.init()
    }
    
    var subtitle: String? {
        return location.found ? location.afterText : location.startText
    }
    
    var title: String? {
        return location.name
    }

}
