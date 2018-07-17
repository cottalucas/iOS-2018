//
//  SelfDrivingCar.swift
//  classPrototype
//
//  Created by Lucas Cotta on 7/17/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import Foundation

class SelfDrivingCar : Car {
    var destination = "One Infinity Loop"
    
    override func Drive() {
        super.drive()
        
        print("Driving towards " + destination)
    }
}
