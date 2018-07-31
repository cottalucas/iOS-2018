//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Update by Lucas Cotta
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //API constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e0cbbc39346572a8ab122b0319679431"
    
    //GPS instatiation
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //getWeatherData method
    func getWeatherData(url:String, weatherAPIParam: Dictionary<String, String>) {
        Alamofire.request(url, method: .get, parameters: weatherAPIParam).responseJSON{
            response in
            if response.result.isSuccess {
                let WeatherDataInJSON: JSON = JSON(response.result.value!)
                self.JSONParsing(JSONData: WeatherDataInJSON)
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection issues"
            }
        }
    }

    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    func JSONParsing(JSONData: JSON) {
        print(JSONData)
        let humidity = JSONData["main"]["humidity"]
        let temp = JSONData["main"]["temp"]
        let location = JSONData["name"]
    }
    
    //updateWeatherData method
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //updateUIWithWeatherData
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[locations.count - 1]
        if currentLocation.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let latitude = String(currentLocation.coordinate.latitude)
            let longitude = String(currentLocation.coordinate.longitude)
            
            let weatherAPIParam: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, weatherAPIParam: weatherAPIParam)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "GPS Unavailable"
    }
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


