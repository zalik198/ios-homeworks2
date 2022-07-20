//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Shom on 19.05.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func checker(loginType: LoginType, logTF: String, passTF: String)
}

class LoginInspector: LoginViewControllerDelegate {
    func checker(loginType: LoginType, logTF: String, passTF: String) {
        Checker.shared.checkLogPass(loginType: loginType, log: logTF, pass: passTF)

    }

    
}
