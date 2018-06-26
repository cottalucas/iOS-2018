//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Update by Lucas Cotta
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = Data()
    var chooseAnswer: Bool = false
    var questionsAnsewered: Int = 0
    var round: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = allQuestions.list[1].questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            chooseAnswer = true
        } else {
            chooseAnswer = false
        }
        checkAnswer()
        updateUI()
        nextQuestion()
        round += 1
        if round == 13 {
            startOver()
        }
    }
    
    
    func updateUI() {
        // TODO
    }
    

    func nextQuestion() {
        questionLabel.text = allQuestions.list[Int(arc4random_uniform(13))].questionText
    }

    
    func checkAnswer() {
        let question = allQuestions.list[1]
        if chooseAnswer == question.answer {
            questionsAnsewered += 1
            progressLabel.text = String(questionsAnsewered) + "/13"
            score += 300
            scoreLabel.text = "Score: \(score)"
        } else {
            questionsAnsewered += 1
            progressLabel.text = String(questionsAnsewered) + "/13"
        }
    }
    
    
    func startOver() {
        questionsAnsewered = 0
        round = 0
        score = 0
        
        // Show alert result to the user
        let alertController = UIAlertController(title: "Congratulations", message:
            "You scored \(score)/3900. Keep it up", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
