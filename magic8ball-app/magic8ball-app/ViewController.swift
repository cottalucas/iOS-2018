//
//  ViewController.swift
//  magic8ball-app
//
//  Created by Lucas Cotta on 6/13/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eightBallImage: UIImageView!
    @IBOutlet weak var rollMeButtonUI: UIButton!
    var eightBallImageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Make the button rounded
        rollMeButtonUI.layer.cornerRadius = 12.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rollMeButton(_ sender: Any) {
        roll()
    }
    
    func roll(){
        eightBallImageIndex = Int(arc4random_uniform(5) + 1)
        eightBallImage.image = UIImage(named: "ball" + String(eightBallImageIndex))
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        roll()
    }
    
}

