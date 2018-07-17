//
//  main.swift
//  classPrototype
//
//  Created by Lucas Cotta on 7/16/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import Foundation

var standardCar = Car()
var customizedCat = Car(chosenColor: "Red", chosenCarType: .Hatchback)

standardCar.drive()

var standardSelfDriveCar = SelfDrivingCar()

standardSelfDriveCar.drive()


