//
//  Car.swift
//  classPrototype
//
//  Created by Lucas Cotta on 7/16/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import Foundation

enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    var color: String = "Black"
    var numberOfSeats: Int = 5
    var typeOfCar: CarType = .Sedan
    
    init() {
    }
    
    convenience init(chosenColor: String, chosenCarType: CarType) {
        self.init()
        color = chosenColor
        typeOfCar = chosenCarType
    }
    
    func drive() {
        print("Car is moving")
    }
}
