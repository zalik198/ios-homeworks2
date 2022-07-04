//
//  Checker.swift
//  Navigation
//
//  Created by Shom on 19.05.2022.
//

import Foundation

class Checker {

    static let shared = Checker()
    
    private init() {}
    
    private let login = "admin"
    private let pswd = "admin"
    
    func checkLogPass(log: String, pass: String) -> Bool {
        log == login && pass == pswd
    }
}
