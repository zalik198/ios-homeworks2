//
//  Support.swift
//  Navigation
//
//  Created by Shom on 07.03.2022.
//

import UIKit

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
    
}

let postArray = [Post(author: "Фильмы", description: "Золотой теленок", image: "ostap", likes: 1211, views: 2354),
                 Post(author: "Фильмы", description: "12 Стульев", image: "12chairs", likes: 125, views: 314),
                 Post(author: "Фильмы", description: "Кин-дза-дза", image: "kin-dza-dza", likes: 1556, views: 3154),
                 Post(author: "Фильмы", description: "Приключения электроника", image: "electronik", likes: 3456, views: 10554)
]



public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
}

