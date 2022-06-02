//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import UIKit
import StorageService

let myPhotoArray = ["ostap", "12chairs", "kin-dza-dza", "electronik"]

final class ProfileViewModel {
    
    public var postArray = [Post(author: "Золотой теленок", description: "Фильм", image: myPhotoArray[0], likes: 1211, views: 2354),
                            Post(author: "12 Стульев", description: "Фильм", image: myPhotoArray[1], likes: 125, views: 314),
                            Post(author: "Кин-дза-дза", description: "Фильм", image: myPhotoArray[2], likes: 1556, views: 3154),
                            Post(author: "Приключения электроника", description: "Фильм", image: myPhotoArray[3], likes: 3456, views: 10554)
    ]
    
}
