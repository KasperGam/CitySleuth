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

let LOCATION_FOUND_NOTIFICATION = "com.citysleuth.locationfound"

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var curCase: Case?
    
    var locationManager : CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var startAtLabel: UILabel!
    
    @IBOutlet weak var descriptionText: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var audioPlayer: AudioPlayerView!
    
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var takeQuiz: UIButton!
    
    @IBOutlet weak var rangeIndicator: UIImageView!
    
    
    var tap = UITapGestureRecognizer(target: nil, action: #selector(hideTipView))
    
    var quizView : UIView?
    
    var userLocaiton : CLLocationCoordinate2D?
    
    var currentLoc : Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(hideTipView))
        
        audioPlayer.isHidden = true
        audioPlayer.setEnabled(enabled: false)
        audioPlayer.callWhenAudioStops = afterAudio
        
        tipView.isUserInteractionEnabled = false
        tipView.isHidden = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        startAtLabel.text = "Starting Point"
        
        takeQuiz.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        takeQuiz.layer.borderColor = UIColor.white.cgColor
        takeQuiz.layer.borderWidth = 1
        takeQuiz.layer.cornerRadius = 5
        
        takeQuiz.isHidden = true
        takeQuiz.isUserInteractionEnabled = false
        
        if (CLLocationManager.locationServicesEnabled()) {
            startUpdates()
        }
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        mapView.showsUserLocation = true
        let startAnn = LocationAnnotation(location: (curCase?.locations.first!)!)
        mapView.addAnnotation(startAnn)
        
        if curCase?.curLoc != nil {
            if (mapView != nil) {
                mapView.removeFromSuperview()
            }
            currentLoc = curCase?.curLoc
            showObjective(objective: (currentLoc?.objective)!)
            backgroundImage.image = UIImage(named: (currentLoc?.backgroundImg)!)
            startAtLabel.text = (currentLoc?.name)!
        }
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
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
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
                    if lLoc.distance(from: location!) <= 40.0 {
                        curCase?.discoveredLocation(location: l)
                        if mapView != nil && view.subviews.contains(mapView) {
                            mapView.removeFromSuperview()
                        }
                        NotificationCenter.default.post(name: Notification.Name(rawValue: LOCATION_FOUND_NOTIFICATION), object: self)
                        self.descriptionText.text = ""
                        backgroundImage.image = UIImage(named: l.backgroundImg)
                        self.currentLoc = l
                        self.startAtLabel.text = l.name
                        self.descriptionText.isHidden = true
                        
                        if l.audioFile != "" && l.quiz == nil {
                            startAudio(file: l.audioFile)
                        } else if l.quiz != nil {
                            self.provideQuiz(quiz: l.quiz!)
                        } else {
                            afterAudio()
                        }
                    }
                }
            }
        }
    }
    
    func startAudio (file : String) {
        audioPlayer.isHidden = false
        audioPlayer.setEnabled(enabled: true)
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: "mp3")!)
        self.audioPlayer.songURL = url
        self.audioPlayer.setupPlayer()
        self.audioPlayer.startPlaying()

    }
    
    func afterAudio () {
        self.audioPlayer.setEnabled(enabled: false)
        self.audioPlayer.isHidden = true
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { (Timer) -> () in
                if (self.currentLoc?.tip != "") {
                    self.tipView.isUserInteractionEnabled = true
                    self.tipLabel.text = (self.currentLoc?.tip)!
                    self.tipView.isHidden = false
                    self.backgroundImage.addGestureRecognizer(self.tap)
                    self.view.addGestureRecognizer(self.tap)

                }
            
                self.showObjective(objective: (self.currentLoc?.objective)!)
        })
    }
    
    func provideQuiz(quiz : Quiz) {
        takeQuiz.isHidden = false
        takeQuiz.isUserInteractionEnabled = true
        quizView = UIView(frame: backgroundImage.frame)
        quizView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.view.addSubview(quizView!)
        self.view.bringSubview(toFront: takeQuiz)
    }
    
    @IBAction func pressedToQuiz(_ sender: Any) {
        if currentLoc?.quiz != nil {
            self.performSegue(withIdentifier: "toQuiz", sender: self)
        }
    }
    
    func showObjective(objective : String) {
        self.descriptionText.isHidden = false
        self.descriptionText.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.descriptionText.layer.borderWidth = 1
        self.descriptionText.layer.borderColor = UIColor.white.cgColor
        self.descriptionText.layer.cornerRadius = 5
        let str = NSMutableAttributedString(string: " OBJECTIVE: " + objective)
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location: 1, length: 10))
        str.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 1, length: 10))
        self.descriptionText.attributedText = str

    }
    
    func hideTipView() {
        self.tipView.isUserInteractionEnabled = false
        self.tipView.isHidden = true
        self.backgroundImage.removeGestureRecognizer(tap)
        self.view.removeGestureRecognizer(tap)
    }
    
    
    @IBAction func unwindToMainGame(segue: UIStoryboardSegue) {
        if segue.identifier == "quizToMain" {
            let sourceVC = segue.source as! QuizViewController
            if sourceVC.curQuestionNum >= (curCase?.curQuiz?.questions.count)! {
                if quizView != nil {
                    quizView?.removeFromSuperview()
                }
                takeQuiz.isHidden = true
                takeQuiz.isUserInteractionEnabled = false
                if currentLoc?.audioFile != "" {
                    startAudio(file: (currentLoc?.audioFile)!)
                } else {
                    afterAudio()
                }
            }
        }
    }
    
    func updateMapWithLocation(location : CLLocation) {
        
        let regionRadius: CLLocationDistance = 750
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TO-DO : Create base view controller which these inherit from to simplify this mess
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
        } else if segue.identifier == "toQuiz" {
            let destVC = segue.destination as? QuizViewController
            if destVC != nil {
                destVC?.curCase = curCase
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
