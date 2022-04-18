//
//  Support.swift
//  Navigation
//
//  Created by Shom on 07.03.2022.
//

import UIKit
import StorageService

let myPhotoArray = ["ostap", "12chairs", "kin-dza-dza", "electronik"]

let postArray = [Post(author: "Золотой теленок", description: "Фильм", image: myPhotoArray[0], likes: 1211, views: 2354),
                 Post(author: "12 Стульев", description: "Фильм", image: myPhotoArray[1], likes: 125, views: 314),
                 Post(author: "Кин-дза-дза", description: "Фильм", image: myPhotoArray[2], likes: 1556, views: 3154),
                 Post(author: "Приключения электроника", description: "Фильм", image: myPhotoArray[3], likes: 3456, views: 10554)
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

