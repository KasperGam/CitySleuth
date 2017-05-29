//
//  QuizViewController.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/19/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var quizLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var Q1: UIButton!
    
    @IBOutlet weak var Q2: UIButton!
    
    @IBOutlet weak var Q3: UIButton!
    
    @IBOutlet weak var Q4: UIButton!
    
    var curCase : Case?
    
    var curQuestionNum : Int = 0
    
    var correctAnsNum : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quiz = (curCase?.curQuiz)!
        
        quizLabel.text = (curCase?.curLoc?.name)! + " Quiz"
        
        let curQuestion = quiz.questions[curQuestionNum]
        
        setupQuestion(curQuestion: curQuestion)
    }
    
    func setupQuestion(curQuestion : Question) {
        questionLabel.text = String(curQuestionNum+1) + ": " + curQuestion.question
        
        correctAnsNum = Int(arc4random_uniform(4))
        
        let op1 = Int(arc4random_uniform(3))
        var plus = 0
        
        let buttons = [Q1, Q2, Q3, Q4]
        
        if (correctAnsNum == 0) {
            plus = 1
            self.Q1.setTitle(curQuestion.answer, for: UIControlState.normal)
        }
        
        buttons[plus]?.setTitle(curQuestion.options[op1], for: UIControlState.normal)
        
        let op2 = getOptionWithout(option: op1)
        
        if(correctAnsNum == 1) {
            plus = 1
            self.Q2.setTitle(curQuestion.answer, for: UIControlState.normal)
        }
        
        buttons[plus+1]?.setTitle(curQuestion.options[op2], for: UIControlState.normal)
        
        let op3 = getLastOption(op1: op1, op2: op2)
        
        if(correctAnsNum == 2) {
            plus = 1
            self.Q3.setTitle(curQuestion.answer, for: UIControlState.normal)
        }
        
        buttons[plus+2]?.setTitle(curQuestion.options[op3], for: UIControlState.normal)
        
        if(correctAnsNum == 3) {
            self.Q4.setTitle(curQuestion.answer, for: UIControlState.normal)
        }

    }
    
    func getOptionWithout(option : Int) -> Int {
        var nextOpt = Int(arc4random_uniform(3))
        while(nextOpt == option) {
            nextOpt = Int(arc4random_uniform(3))
        }
        return nextOpt
    }
    
    func getLastOption(op1 : Int, op2 : Int) -> Int {
        let vals = [0,1,2]
        
        for v in vals {
            if v != op1 && v != op2 {
                return v
            }
        }
        return 0
    }
    
    @IBAction func q1Pressed(_ sender: Any) {
        if (correctAnsNum == 0) {
            // Got it right
            curQuestionNum = curQuestionNum + 1
            if curQuestionNum >= (curCase?.curQuiz?.questions.count)! {
                self.performSegue(withIdentifier: "quizToMain", sender: self)
            } else {
                setupQuestion(curQuestion: (curCase?.curQuiz?.questions[curQuestionNum])!)
            }
            
        } else {
            
        }
    }
    
    @IBAction func p2Pressed(_ sender: Any) {
        if (correctAnsNum == 1) {
            // Got it right
            curQuestionNum = curQuestionNum + 1
            if curQuestionNum >= (curCase?.curQuiz?.questions.count)! {
                self.performSegue(withIdentifier: "quizToMain", sender: self)
            } else {
                setupQuestion(curQuestion: (curCase?.curQuiz?.questions[curQuestionNum])!)
            }
            
        } else {
            
        }

    }
    
    @IBAction func q3Pressed(_ sender: Any) {
        if (correctAnsNum == 2) {
            // Got it right
            curQuestionNum = curQuestionNum + 1
            if curQuestionNum >= (curCase?.curQuiz?.questions.count)! {
                self.performSegue(withIdentifier: "quizToMain", sender: self)
            } else {
                setupQuestion(curQuestion: (curCase?.curQuiz?.questions[curQuestionNum])!)
            }
            
        } else {
            
        }

    }
    
    @IBAction func q4Pressed(_ sender: Any) {
        if (correctAnsNum == 3) {
            // Got it right
            curQuestionNum = curQuestionNum + 1
            if curQuestionNum >= (curCase?.curQuiz?.questions.count)! {
                self.performSegue(withIdentifier: "quizToMain", sender: self)
            } else {
                setupQuestion(curQuestion: (curCase?.curQuiz?.questions[curQuestionNum])!)
            }
            
        } else {
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
