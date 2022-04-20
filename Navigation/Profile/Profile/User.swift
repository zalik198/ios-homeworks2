//
//  User.swift
//  Navigation
//
//  Created by Shom on 20.04.2022.
//

import Foundation
import UIKit

protocol UserService {
    func userSetup(_ name: String) -> User?
}

class User {
    var name: String
    var avatar: UIImage?
    var status: String
    
    init(name: String, avatar: UIImage?, status: String) {
        self.name = name
        self.avatar = avatar
        self.status = status
    }
}

class CurrentUserService: UserService {
   private let user: User? = nil
    
    func userSetup(_ name: String) -> User? {
        if let nameUser = user {
            if name == nameUser.name {
                return user
            }
        }
        return nil
    }
    
    
}
