//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Shom on 19.05.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func checker(logTF: String, passTF: String) -> Bool
}

class LoginInspector: LoginViewControllerDelegate {
    func checker(logTF: String, passTF: String) -> Bool {
        return Checker.shared.checkLogPass(log: logTF, pass: passTF)
    }
    
}
