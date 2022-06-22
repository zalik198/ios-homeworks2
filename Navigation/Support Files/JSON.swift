//
//  NetworkManager.swift
//  Navigation
//
//  Created by Shom on 22.06.2022.
//

import Foundation
import UIKit

//ДЗ 2
//Часть 2

struct Planet: Codable {
    var orbitalPeriod: String
    
    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
    }
}

struct MyPlanet {
    let orbitalPeriod: String
    
    init(myPlanet: Planet) {
        orbitalPeriod = myPlanet.orbitalPeriod
        
    }
}




