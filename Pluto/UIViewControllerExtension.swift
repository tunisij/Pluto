//
//  UIViewControllerExtension.swift
//  Pluto
//
//  Created by John Tunisi on 1/12/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validateUsername(username: String) -> Bool {
        return username.characters.count >= 5
    }
    
    func validatePassword(password: String) -> Bool {
        if password.characters.count >= 8 {
            let capitalLetterRegEx  = ".*[A-Z]+.*"
            let numberRegEx  = ".*[0-9]+.*"
        
            let capitalLetterTest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
            let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        
            if capitalLetterTest.evaluateWithObject(password) {
                if numberTest.evaluateWithObject(password) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func validateEmailAddress(emailAddress: String) -> Bool {
        if emailAddress.characters.count >= 5 {
            if emailAddress.characters.contains("@") {
                return true
            }
        }
        
        return false
    }
}
