//
//  Support.swift
//  Navigation
//
//  Created by Shom on 07.03.2022.
//

import UIKit
import StorageService

let postArray = [Post(author: "Золотой теленок", description: "Фильм", image: "ostap", likes: 1211, views: 2354),
                 Post(author: "12 Стульев", description: "Фильм", image: "12chairs", likes: 125, views: 314),
                 Post(author: "Кин-дза-дза", description: "Фильм", image: "kin-dza-dza", likes: 1556, views: 3154),
                 Post(author: "Приключения электроника", description: "Фильм", image: "electronik", likes: 3456, views: 10554)
]

let photosArray = ["3+2", "brilliant", "buratino", "gentlman", "golubi", "ironia", "ivanVasilievich", "kin-dza", "mestoVstrechi", "moskva", "operationY", "roman", "samogon", "skazka", "solnce", "sportloto", "stariki", "svadba", "troeVLodke", "vokzal"]



public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}

