//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Updated by Lucas Cotta
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

protocol changeCityDelegate {
    func ChangeCityViewController(city: String)
}

class ChangeCityViewController: UIViewController {
    
    //MARK: Variables
    var delegate: changeCityDelegate?

    //MARK: IBOutlets
    @IBOutlet weak var changeCityTextField: UITextField!
    
    //MARK: IBActions
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        let city = changeCityTextField.text!
        delegate?.ChangeCityViewController(city: city)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
