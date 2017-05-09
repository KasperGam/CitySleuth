//
//  SuspectsViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/8/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class SuspectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var curCase : Case?
    
    var suspects = [Suspect]()
    
    @IBOutlet weak var suspectsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for s in (curCase?.suspects)! {
            suspects.append(s)
        }
        suspectsTable.delegate = self
        suspectsTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suspects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let suspect = suspects[indexPath.row]
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "suspectCell")
        
        if(suspect.discovered) {
            cell.imageView?.image = UIImage(named: suspect.image)
            cell.textLabel?.text = suspect.name
        } else {
            cell.imageView?.image = UIImage(named: "anonSuspect")
            cell.textLabel?.text = "Locked"
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
