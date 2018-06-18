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

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func notePressed(_ sender: UIButton) {
        let note = sender.tag
        playNote(whichNote: note)
    }
    
    func playNote(whichNote: Int){
        let url = Bundle.main.url(forResource: "note" + String(whichNote), withExtension: "wav")!
    
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as Error {
            print(error.localizedDescription)
        }
    }
}

