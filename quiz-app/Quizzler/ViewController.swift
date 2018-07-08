//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Update by Lucas Cotta
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import KRProgressHUD

class ViewController: UIViewController {
    
    let allQuestions = Data()
    var chooseAnswer: Bool = false
    var score: Int = 0
    var questionsAnsewered = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            chooseAnswer = true
        } else {
            chooseAnswer = false
        }
        checkAnswer()
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = String(questionsAnsewered + 1) + "/13"
        progressBar.frame.size.width = (view.frame.size.width/13) * CGFloat(questionsAnsewered + 1)
    }
    

    func nextQuestion() {
        if questionsAnsewered < 13 {
            questionLabel.text = allQuestions.list[questionsAnsewered].questionText
            updateUI()
        } else {
            // Show alert result to the user
            let alertController = UIAlertController(title: "Congratulations", message:
                "You scored \(score)/3900. Keep it up", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.default, handler:
                { (UIAlertAction) in
                    self.startOver()
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    
    func checkAnswer() {
        if chooseAnswer == allQuestions.list[questionsAnsewered].answer {
            // Update scores
            score += 300
            // Alert result
            KRProgressHUD.showSuccess(withMessage: "😄")
        } else {
            KRProgressHUD.showError(withMessage: "🙁")
        }
        questionsAnsewered += 1
    }
    
    
    func startOver() {
        questionsAnsewered = 0
        score = 0
        
        // Update UI
        scoreLabel.text = "Score: 0000"
        progressLabel.text = "0/13"
        
        nextQuestion()
    }
}
