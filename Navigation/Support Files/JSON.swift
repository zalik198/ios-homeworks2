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




struct Tatooine: Decodable {
    var residents: [String]

    
    enum CodingKeys: String, CodingKey {
        case residents
    }
}

struct MyManager {
    var tatooine = [String]()
    
    func fetchData() {
        
        let jsonURLString = "https://swapi.dev/api/planets/1"
        
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            
            do {
                let planet = try JSONDecoder().decode(Tatooine.self, from: data)
                print("\(planet)")                
                
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    
    
    
    
}



