//
//  Quiz.swift
//  City Sleuth
//
//  Created by Kasper Gammeltoft on 5/15/17.
//  Copyright © 2017 Locative Media Group 17' ITU. All rights reserved.
//

import Foundation

class Quiz {
    
    var id : Int
    
    var questions : Array<Question> = []
    
    var completed = false
    
    init(id : Int, questions : Array<Question>) {
        self.id = id
        self.questions = questions
    }
    
}

class Question {
    
    var options : Array<String> = []
    
    var answer : String
    
    var question : String
    
    init(options : Array<String>, answer : String, question : String) {
        self.options = options
        self.answer = answer
        self.question = question
    }
    
}
