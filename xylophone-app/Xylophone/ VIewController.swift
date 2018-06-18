//
//  ViewController.swift
//  Xylophone
//
//  Skeleton Created by Angela Yu on 27/01/2016.
//  Updated by Lucas Cotta on 18/06/2018
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func notePressed(_ sender: UIButton) {
        playNote()
    }
    
    func playNote(){
        var notesSound: AVAudioPlayer!
        let soundPath = Bundle.main.path(forResource: "note1", ofType: "wave")!
        let url = URL(fileURLWithPath: soundPath)
        do {
            notesSound = try AVAudioPlayer(contentsOf: url)
            notesSound.play()
        } catch  {
            print("Audio file not found")
        }
    }
}

