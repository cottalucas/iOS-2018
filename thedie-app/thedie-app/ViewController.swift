//
//  ViewController.swift
//  thedie-app
//
//  Created by Lucas Cotta on 6/12/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Dice index
    var randomIndexDieOne: Int = 0
    var randomIndexDieTwo: Int = 0
    
    @IBOutlet weak var dieOne: UIImageView!
    @IBOutlet weak var dieTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rollAction(_ sender: Any) {
        updateDiceImages()
    }
    
    func updateDiceImages(){
        randomIndexDieOne = Int(arc4random_uniform(6) + 1)
        randomIndexDieTwo = Int(arc4random_uniform(6) + 1)
        
        dieOne.image = UIImage(named:"dice" + String(randomIndexDieOne))
        dieTwo.image = UIImage(named: "dice" + String(randomIndexDieTwo))
    }
    
    // Roll the dice on the end of a shake event
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    

}

