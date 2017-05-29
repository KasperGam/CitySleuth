//
//  Cases.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/5/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import Foundation



class Cases {
    
    var ALL_CASES : Array<Case>
    
    var currentCase : Case
    
    var nextCase : Case?
    
    init() {
        
        ALL_CASES = [Case]()
        let filepath = Bundle.main.path(forResource: "casedata", ofType: "json")!
        let data = NSData(contentsOfFile: filepath)!
        let json = JSON(data)
        print(json)
        for(_, item) in json {
            let name = item["name"].string!
            let id = item["id"].int!
            let image = item["image"].string!
            let date = item["date"].string!
            let crime = item["crime"].string!
            let victim = item["victim"].string!
            let briefImg = item["briefingImage"].string!
            let startplace = item["startName"].string!
            let location = item["location"].string!
            var suspects = [Suspect]()
            for(sitem) in item["suspects"].array! {
                let sname = sitem["name"].string!
                let sage = sitem["age"].int!
                let simage = sitem["image"].string!
                let sid = sitem["id"].int!
                let ssex = sitem["sex"].string!
                let soccupation = sitem["occupation"].string!
                let srelationship = sitem["relationship"].string!
                let salibi = sitem["alibi"].string!
                let stestimony = sitem["testimony"].string!
                suspects.append(Suspect(sName: sname, sAge: sage, sID: sid, sOcc: soccupation, sAlibi: salibi, sTestimony: stestimony, sRelation: srelationship, sSex: ssex, sImage: simage))
            }
            
            var quizes = [Quiz]()
            for(qitem) in item["quizes"].array! {
                
                let qid = qitem["id"].int!
                var qqestions = [Question]()
                for(qqitem) in qitem["questions"].array! {
                    let qqoptions = qqitem["options"].arrayObject!
                    let qqquestion = qqitem["question"].string!
                    let qqanswer = qqitem["answer"].string!
                    qqestions.append(Question(options: qqoptions as! Array<String>, answer: qqanswer, question: qqquestion))
                }
                quizes.append(Quiz(id: qid, questions: qqestions))
            }
            
            var locations = [Location]()
            for(litem) in item["locations"].array! {
                let lname = litem["name"].string!
                let laddress = litem["address"].string!
                let lid = litem["id"].int!
                let lbackground = litem["backgroundImage"].string!
                let llat = litem["latitude"].double!
                let llong = litem["longitude"].double!
                let lstart = litem["startText"].string!
                let lafter = litem["afterText"].string!
                let lsuspects = litem["suspects"].arrayObject!
                let lunlocks = litem["unlockLocations"].arrayObject!
                let levidence = litem["evidence"].arrayObject!
                let lhints = litem["hints"].arrayObject!
                let laudio = litem["audioFile"].string!
                let ltip = litem["afterTip"].string!
                let lobjective = litem["afterObjective"].string!
                let lquiz = litem["quiz"].int!
                
                locations.append(Location(name: lname, address: laddress, id: lid, latitude: llat, longitude: llong, startTxt: lstart, aftText: lafter, unlocks: lunlocks as! Array<Int>, suspects: lsuspects as! Array<Int>, evidence: levidence as! Array<Int>, background: lbackground, hints: lhints as! Array<Int>, audioFile : laudio, tip : ltip, objective : lobjective))
                
                if lquiz >= 0 {
                    for q in quizes {
                        if q.id == lquiz {
                            locations.last?.quiz = q
                            break
                        }
                    }
                }
            }
            
            var evidence = [Evidence]()
            for(eitem) in item["evidence"].array! {
                let ename = eitem["name"].string!
                let eid = eitem["id"].int!
                let edesc = eitem["description"].string!
                let efile = eitem["filename"].string!
                let etype = eitem["type"].string!
                let ediscover = eitem["discoveredAt"].string!
                evidence.append(Evidence(name: ename, id: eid, desc: edesc, filename: efile, type: etype, discoveredAt: ediscover))
                if (eid < 0) {
                    evidence.last?.discovered = true
                }
            }
            
            var hints = [Hint]()
            for(hitem) in item["hints"].array! {
                let hid = hitem["id"].int!
                let hhint = hitem["hint"].string!
                hints.append(Hint(id: hid, hint: hhint))
            }

            ALL_CASES.append(Case(caseName: name, caseID: id, imgName: image, suspects: suspects, date: date, victim: victim, crime: crime, briefImage: briefImg, startName: startplace, location: location, locations: locations, evidence: evidence, hints: hints, quizes: quizes))
        }
        
        currentCase = ALL_CASES[0]
        nextCase = ALL_CASES.count > 1 ? ALL_CASES[1] : nil
    }
    
    func selectCase(selectedCase : Case) {
        currentCase = selectedCase
        for i in 0 ... ALL_CASES.count-1 {
            let c : Case = ALL_CASES[i]
            if (c === selectedCase) {
                if (i + 1 < ALL_CASES.count) {
                    nextCase = ALL_CASES[i+1]
                } else {
                    nextCase = nil
                }
            }
        }
    }
    
    func previousCase(curCase : Case) -> Case? {
        for i in 0 ... ALL_CASES.count-1 {
            let c : Case = ALL_CASES[i]
            if (c === curCase) {
                if (i > 0) {
                    return ALL_CASES[i-1]
                } else {
                    return nil
                }
            }
        }
        return nil
    }

}

