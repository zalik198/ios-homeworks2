//
//  PostTableViewCellModel.swift
//  Navigation
//
//  Created by Shom on 27.07.2022.
//

import Foundation
import UIKit

class PostTbaleViewCellModel {
    var post: Post
    
    var author: String {
        return post.author
    }
    
    var description: String {
        return post.description
    }
    
    var image: String {
        return post.image
    }
    
    var likes: Int {
        return post.likes
    }
    
    var views: Int {
        return post.views
    }
    
    
    init(post: Post) {
        self.post = post
    }
    
    
}
