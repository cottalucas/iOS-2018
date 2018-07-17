//
//  ViewController.swift
//  W3lcome Face Comparison
//
//  Created by Lucas Cotta on 7/17/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit
import AWSCore
import AWSRekognition

class ViewController: UIViewController {

    @IBAction func compareImage(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rekognitionClient = AWSRekognition.default()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var rekognitionClient: AWSRekognition!
    
    func calculateFaceComparison () {
        
    }


}

