//
//  NetworkManager.swift
//  Navigation
//
//  Created by Shom on 22.06.2022.
//

import Foundation
import UIKit

//ДЗ 2


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

struct Name: Decodable {
    var name: String
}

//class MyManager {
//    var residentsURL = [String]()
//    var residents = [String]()
//
//    func fetchData() {
//
//        let jsonURLString = "https://swapi.dev/api/planets/1"
//
//        guard let url = URL(string: jsonURLString) else { return }
//        URLSession.shared.dataTask(with: url) { data, responce, error in
//            guard let data = data else { return }
//
//            do {
//                let planetURL = try JSONDecoder().decode(Tatooine.self, from: data)
//                DispatchQueue.main.async {
//
//                }
//
//                for i in planetURL.residents {
//                    self.residentsURL.append(i)
//                }
//                if self.residentsURL == self.residentsURL {
//                    print("\(self.residentsURL)")
//                    self.residentsURL.forEach { url in
//                        if let url = URL(string: url) {
//                            URLSession.shared.dataTask(with: url) { data, responce, error in
//                                if let data = data {
//                                    do {
//                                        let residData = try JSONDecoder().decode(Name.self, from: data)
//                                        print(residData.name)
//                                    } catch let error {
//                                        print(error.localizedDescription)
//                                    }
//                                }
//                            }.resume()
//                        }
//                    }
//                }
//
//            } catch let error {
//                print(error.localizedDescription)
//            }
//
//        }.resume()
//    }
//
//
//    func myView() {
//
//
//    }
//
//}
//


