//
//  CaseChooserViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/5/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class CaseChooserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var caseImage: UIImageView!
    
    @IBOutlet weak var nextCase: UIButton!
    
    @IBOutlet weak var previousCase: UIButton!
    
    @IBOutlet weak var caseSearch: UITextField!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var recommendedLabel: UILabel!
    
    @IBOutlet weak var locIcon: UIImageView!
    
    @IBOutlet weak var destLabel: UILabel!
    
    @IBOutlet weak var worldIcon: UIImageView!
    
    var cases : Cases = Cases()
    var currentCase : Case? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCase = cases.currentCase
        
        caseSearch.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        caseImage.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        caseSearch.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func unwindToCasePicker(segue: UIStoryboardSegue) {
    }
    
    @IBAction func nextCase(_ sender: AnyObject) {
        if (cases.nextCase == nil) {
            currentCase = nil
            nextCase.isEnabled = false
            caseImage.image = UIImage(named: "morecomingsoon")
            nameLabel.text = ""
            recommendedLabel.isHidden = true
            locIcon.isHidden = true
            self.worldIcon.isHidden = true
            destLabel.isHidden = true
        } else {
            currentCase = cases.nextCase
            cases.selectCase(selectedCase: currentCase!)
            caseImage.image = UIImage(named: (currentCase?.imageName)!)
            nameLabel.text = (currentCase?.name)!
        }
        previousCase.isEnabled = true
    }
    
    @IBAction func previousCase(_ sender: AnyObject) {
        if (currentCase == nil) {
            currentCase = cases.ALL_CASES.last
            self.worldIcon.isHidden = false
            destLabel.isHidden = false
        } else {
            currentCase = cases.previousCase(curCase: currentCase!)
        }
        if (currentCase === cases.ALL_CASES.first) {
            previousCase.isEnabled = false
        }
        caseImage.image = UIImage(named: (currentCase?.imageName)!)
        nameLabel.text = (currentCase?.name)!
        nextCase.isEnabled = true
        if (currentCase?.location)! == "Denmark, Copenhagen" {
            recommendedLabel.isHidden = false
            locIcon.isHidden = false
        }
    }
    
    @IBAction func pickCase(_ sender: AnyObject) {
        if currentCase != nil {
            self.performSegue(withIdentifier: "toCaseDescription", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as? CaseBriefingViewController
        if (destVC != nil) {
                destVC?.curCase = currentCase
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
