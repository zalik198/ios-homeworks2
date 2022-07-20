//
//  Checker.swift
//  Navigation
//
//  Created by Shom on 19.05.2022.
//

import Foundation
import FirebaseAuth

enum LoginType {
    case signIn
    case SignUp
}

class Checker {

    static let shared = Checker()
    var completion: ((_ message: String) -> Void)?
    
    private init() {}
    
    //private let login = "admin"
    //private let pswd = "admin"
    
    public func checkLogPass(loginType: LoginType, log: String, pass: String) {
        switch loginType {
        case .signIn:
            Auth.auth().signIn(withEmail: log, password: pass) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    if let completion = self.completion {
                        completion (error.localizedDescription)
                    }
                }
                
            }
        case .SignUp:
            Auth.auth().createUser(withEmail: log, password: pass) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    if let completion = self.completion {
                        completion (error.localizedDescription)
                    }
                }
            }
        }
        
    
    }
}
