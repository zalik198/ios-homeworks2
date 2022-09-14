//
//  LocalAuthentification.swift
//  Navigation
//
//  Created by Shom on 14.09.2022.
//

import Foundation
import LocalAuthentication

 class LocalAuthorizationService {


     func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {

         let context = LAContext()
         context.localizedCancelTitle = "Отмена"
         context.localizedFallbackTitle = "Пароль"
         var error: NSError?

         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       localizedReason: "Авторизация по Face ID не прошла!") { (success, error) in
                    authorizationFinished(success)
                }
            }
     }



 }
