//
//  CaseBriefingViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/6/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class CaseBriefingViewController: UIViewController {

    var curCase: Case?
    
    @IBOutlet weak var briefingView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        briefingView.image = UIImage(named: (curCase?.briefingImage)!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as? MainViewController
        if destVC != nil {
            destVC?.curCase = curCase
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
