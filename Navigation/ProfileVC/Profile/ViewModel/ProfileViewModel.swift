//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import UIKit
import StorageService

let myPhotoArray = ["ostap", "12chairs", "kin-dza-dza", "electronik"]


public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
    public var id: String
    
}

final class ProfileViewModel {
    
    public var postArray = [Post(author: "Золотой теленок", description: "Фильм", image: "ostap", likes: 1211, views: 2354, id: "12g3"),
                            Post(author: "12 Стульев", description: "Фильм", image: "12chairs", likes: 125, views: 314, id: "6y31d"),
                            Post(author: "Кин-дза-дза", description: "Фильм", image: "kin-dza-dza", likes: 1556, views: 3154, id: "9cdss9"),
                            Post(author: "Приключения электроника", description: "Фильм", image: "electronik", likes: 3456, views: 10554, id: "xsa6")
    ]
    
    func numberOfRows() -> Int {
        return postArray.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTbaleViewCellModel? {
        let post = postArray[indexPath.row]
        return PostTbaleViewCellModel(post: post)
    }
    
}
