//
//  SignupViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/15/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        
        emailAddressTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailAddressTextField {
            if validateEmailAddress(emailAddressTextField.text!) {
                textField.resignFirstResponder()
                usernameTextField.becomeFirstResponder()
            } else {
                displayOkAlert("Invalid", message: "Invalid email address.", sender: self)
            }
        } else if textField == usernameTextField {
            if validateUsername(usernameTextField.text!) {
                textField.resignFirstResponder()
                passwordTextField.becomeFirstResponder()
            } else {
                displayOkAlert("Invalid", message: "Username must be at least 5 characters.", sender: self)
            }
        } else if textField == passwordTextField {
            if validatePassword(passwordTextField.text!) {
                textField.resignFirstResponder()
               signupButtonClicked(passwordTextField)
            } else {
                displayOkAlert("Invalid", message: "Password must be at least 8 characters and contain at least one capital letter and one number.", sender: self)
            }
        }
        return true
    }
    
    @IBAction func signupButtonClicked(sender: AnyObject) {
        if !validateEmailAddress(emailAddressTextField.text!) {
            displayOkAlert("Invalid", message: "Invalid email address.", sender: self)
        } else if !validateUsername(usernameTextField.text!) {
            displayOkAlert("Invalid", message: "Username must be at least 5 characters.", sender: self)
        } else if !validatePassword(passwordTextField.text!) {
            displayOkAlert("Invalid", message: "Password must be at least 8 characters and contain at least one capital letter and one number.", sender: self)
        } else {
            let newUser = PFUser()
            newUser.username = usernameTextField.text
            newUser.password = passwordTextField.text
            newUser.email = emailAddressTextField.text
            newUser.signUpInBackgroundWithBlock({ (suceed, error) -> Void in
                if error != nil {
                    if error!.code == 202 {
                        displayOkAlert("Error", message: "Username \(self.usernameTextField.text) already taken", sender: self)
                    }
                    displayOkAlert("Error", message: "\(error)", sender: self)
                } else {
                    if PFUser.currentUser() != nil {
                        self.performSegueWithIdentifier("signupSegue", sender: self)
                    } else {
                        displayOkAlert("Invalid", message: "An error has occured.", sender: self)
                    }
                }
            })
        }
    }
    
    
    
}