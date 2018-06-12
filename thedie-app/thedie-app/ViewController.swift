//
//  ViewController.swift
//  thedie-app
//
//  Created by Lucas Cotta on 6/12/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randonIndexDieOne: Int = 0
    var randonIndexDieTwo: Int = 0
    
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
        randonIndexDieOne = Int(arc4random_uniform(6) + 1)
        randonIndexDieTwo = Int(arc4random_uniform(6) + 1)
        
        dieOne.image = UIImage(named:"dice" + String(randonIndexDieOne))
        dieTwo.image = UIImage(named: "dice" + String(randonIndexDieTwo))
    }
    

}

