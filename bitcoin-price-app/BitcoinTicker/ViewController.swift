//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Updated by Lucas Cotta
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Variables
    /***************************************************************/
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var selectedCurrency = ""

    //MARK: IBOutlets
    /***************************************************************/
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate location
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }
    
    //MARK: UIPicker methods
    /***************************************************************/
    
    //Columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    //Data
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    //Retrieve picker data + invoke parser
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currencyArray[row] as String
        getBitcoinData(url: String(baseURL+selectedCurrency))
    }
    

    //MARK: - Networking
    /***************************************************************/
    
    func getBitcoinData(url: String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
                if response.result.isSuccess {
                    let dailyValueJSON: JSON = JSON(response.result.value!)
                    self.updateBicoinValueData(json: dailyValueJSON)
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }
    
    func updateBicoinValueData(json : JSON) {
 
        let currentValue: Double = json["ask"].double!
        updateUIWithWeatherData(withNewValue: String(currentValue))
    }
    
    //MARK: - UI
    /***************************************************************/
    
    func updateUIWithWeatherData(withNewValue : String){
        bitcoinPriceLabel.text = withNewValue
    }
    
}

