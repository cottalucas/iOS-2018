//
//  Question.swift
//  Quizzler
//
//  Created by Lucas Cotta on 6/20/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    var questionText: String
    var answer: Bool
    
    init(text: String, givenAnswer: Bool) {
        questionText = text
        answer = givenAnswer
    }

}
