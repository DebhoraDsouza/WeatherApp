//
//  LoginViewModel.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 19/11/20.
//

import UIKit
import LocalAuthentication

class LoginViewModel: NSObject {
    
    var showAlert:((_ title:String, _ message :String)->Void)?
    var showPlaceSearchVC:(()->Void)?


    override init() {
        super.init()
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.showPlaceSearchVC?()
                    } else {
                        self.showAlert?("Authentication failed","Sorry!" )
                    }
                }
            }
        } else {
            self.showAlert?("Touch ID not available","Your device is not configured for Touch ID.")
        }
    }
}
