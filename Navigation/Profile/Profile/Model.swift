//
//  Model.swift
//  Navigation
//
//  Created by Shom on 20.05.2022.
//

import Foundation

final class Model {
    
    private var password = "admin"
    
    
    func check(word: String) {
        guard word != "" else { return }
        
        if word == password {
            NotificationCenter.default.post(name: NSNotification.Name.green, object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.red, object: nil)
        }
    }
}
