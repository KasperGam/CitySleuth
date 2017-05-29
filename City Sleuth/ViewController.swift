//
//  ViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/5/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet weak var howtoplayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        
        aboutButton.layer.borderWidth = 2
        aboutButton.layer.borderColor = UIColor.white.cgColor
        
        howtoplayButton.layer.borderWidth = 2
        howtoplayButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
    }
    


}

