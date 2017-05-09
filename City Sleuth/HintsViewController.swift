//
//  HintsViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class HintsViewController: UIViewController {
    
    @IBOutlet weak var hintText: UILabel!
    
    var curCase : Case?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hintText.text = curCase?.currentHint?.hint
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
