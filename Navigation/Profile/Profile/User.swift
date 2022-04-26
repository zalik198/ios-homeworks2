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
    let currentUser: User? = nil
    
    func userSetup(_ name: String) -> User? {
        if let myNameUser = currentUser {
            if name == myNameUser.name {
                return currentUser
            }
        }
        return nil
    }
}

class TestUserService: UserService {
    let testUser = User(name: "Шура", avatar: UIImage(named: "Шура"), status: "Балаганов")
    
    func userSetup(_ name: String) -> User? {
        if name == testUser.name {
            return nil
        }
        return testUser
    }
    
}
