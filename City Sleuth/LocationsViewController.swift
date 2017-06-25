//
//  LocationsViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var curCase : Case?
    
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var rangeIndicator: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
                
        if (CLLocationManager.locationServicesEnabled()) {
            startUpdates()
        }
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        
        for l in (curCase?.locations)! {
            if l.found || curCase?.locations.first === l{
                mapView.addAnnotation(LocationAnnotation(location: l))
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(unwindToMain), name: NSNotification.Name(rawValue: LOCATION_FOUND_NOTIFICATION), object: nil)
    }
    
    func unwindToMain() {
        self.performSegue(withIdentifier: "locationToMain", sender: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            startUpdates()
        }
    }
    
    func startUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 20
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location : CLLocation?
        if locations.last != nil {
            location = locations.last!
        }
        let date = location!.timestamp
        let recentTime = date.timeIntervalSinceNow
        
        if (abs(recentTime) < 15.0) {
            // Update map
            updateMapWithLocation(location: location!)
            
            for l in (curCase?.locations)! {
                if (curCase?.canDiscoverLocation(location: l))! {
                    let lLoc = CLLocation(latitude: l.lat, longitude: l.long)
                    
                    if l !== curCase?.curLoc {
                        let dist = lLoc.distance(from: location!)
                        if dist <= 200.0 {
                            rangeIndicator.image = #imageLiteral(resourceName: "closeIndicator")
                        } else if dist <= 1000.0 {
                            rangeIndicator.image = #imageLiteral(resourceName: "halfwayIndicator")
                        } else {
                            rangeIndicator.image = #imageLiteral(resourceName: "farAwayIndicator")
                        }
                    }
                }
            }
        }
    }

    func updateMapWithLocation(location : CLLocation) {
        
        let regionRadius: CLLocationDistance = 750
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
