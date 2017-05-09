//
//  EvidenceViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class EvidenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var evidenceTable: UITableView!
    
    var curCase : Case?
    
    var selectedEvidence : Evidence?
    
    var evidence = [Evidence]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        evidenceTable.dataSource = self
        evidenceTable.delegate = self
        
        for e in (curCase?.evidence)! {
            if e.discovered {
                evidence.append(e)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evidence.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let curE = evidence[indexPath.row]
                
        let cell = EvidenceTableCell(style: UITableViewCellStyle.default, reuseIdentifier: "evidenceCell")
        
        cell.textLabel?.text = curE.name
        cell.imageView?.image = UIImage(named: curE.type)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath){
        var evidence = (curCase?.evidence)!
        
        self.selectedEvidence = evidence[indexPath.row]
        
        performSegue(withIdentifier: "toEvidenceInspector", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as? EvidencePeiceViewController
        destVC?.curEvidence = self.selectedEvidence
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToEvidence(segue: UIStoryboardSegue) {
    }
    
}

class EvidenceTableCell : UITableViewCell {
    
}
