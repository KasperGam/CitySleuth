//
//  MainViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/6/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var curCase: Case?
    
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var startAtLabel: UILabel!
    
    @IBOutlet weak var descriptionText: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var audioPlayer: AudioPlayerView!
    
    var userLocaiton : CLLocationCoordinate2D?
    
    var currentLoc : Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer.isHidden = true
        audioPlayer.setEnabled(enabled: false)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        startAtLabel.text = (curCase)?.startplace
        
        if (CLLocationManager.locationServicesEnabled()) {
            startUpdates()
        }
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        let startAnn = LocationAnnotation(location: (curCase?.locations.first!)!)
        mapView.addAnnotation(startAnn)
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
            
            if mapView != nil && view.subviews.contains(mapView) {
                updateMapWithLocation(location: location!)
            }
            for l in (curCase?.locations)! {
                if (curCase?.canDiscoverLocation(location: l))! {
                    let lLoc = CLLocation(latitude: l.lat, longitude: l.long)
                    if lLoc.distance(from: location!) <= 40.0 {
                        curCase?.discoveredLocation(location: l)
                        if mapView != nil && view.subviews.contains(mapView) {
                            mapView.removeFromSuperview()
                        }
                        backgroundImage.image = UIImage(named: l.backgroundImg)
                        self.currentLoc = l
                        self.startAtLabel.text = l.name
                        self.audioPlayer.isHidden = false
                        self.audioPlayer.setEnabled(enabled: true)
                    }
                }
            }
        }
        
    }
    
    @IBAction func unwindToMainGame(segue: UIStoryboardSegue) {
    }
    
    func updateMapWithLocation(location : CLLocation) {
        
        let regionRadius: CLLocationDistance = 750
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSuspects" {
            let destVC = segue.destination as? SuspectsViewController
            if destVC != nil {
                destVC?.curCase = curCase
            }
        } else if segue.identifier == "toEvidence" {
            let destVC = segue.destination as? EvidenceViewController
            if destVC != nil {
                destVC?.curCase = curCase
            }
        } else if segue.identifier == "toLocations" {
            let destVC = segue.destination as? LocationsViewController
            if destVC != nil {
                destVC?.curCase = curCase
            }
        } else if segue.identifier == "toHints" {
            let destVC = segue.destination as? HintsViewController
            if destVC != nil {
                destVC?.curCase = curCase
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
