//
//  SuspectProfileViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/10/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class SuspectProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var occupationLabel: UILabel!
    
    @IBOutlet weak var relationshipLabel: UILabel!
    
    @IBOutlet weak var alibiLabel: UILabel!
    
    @IBOutlet weak var testimonyView: UITextView!
    
    var curSuspect : Suspect?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if curSuspect != nil {
            imageView.image = UIImage(named: (curSuspect?.image)!)
            nameLabel.text = (curSuspect?.name)!
            dateLabel.text = "22/4/17"
            ageLabel.text = String((curSuspect?.age)!)
            sexLabel.text = (curSuspect?.sex)!
            occupationLabel.text = (curSuspect?.occupaiton)!
            relationshipLabel.text = (curSuspect?.relation)!
            alibiLabel.text = (curSuspect?.alibi)!
            testimonyView.text = (curSuspect?.testimony)!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
