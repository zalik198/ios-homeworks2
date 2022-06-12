//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Shom on 02.06.2022.
//

import Foundation


final class FeedViewModel {
    
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