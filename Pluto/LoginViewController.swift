//
//  ViewController.swift
//  Pluto
//
//  Created by John Tunisi on 12/20/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        
        username.delegate = self
        password.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == username {
            if validateUsername(username.text!) {
                textField.resignFirstResponder()
                password.becomeFirstResponder()
            } else {
                displayOkAlert("Invalid", message: "Username must be at least 5 characters.", sender: self)
            }
        } else if textField == password {
            if validatePassword(password.text!) {
                textField.resignFirstResponder()
                loginButtonClicked(password)
            } else {
                displayOkAlert("Invalid", message: "Password must be at least 8 characters and contain at least one capital letter and one number.", sender: self)
            }
        }
        return true
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        if !validateUsername(username.text!) {
            displayOkAlert("Invalid", message: "Username must be at least 5 characters.", sender: self)
        } else if !validatePassword(password.text!) {
            displayOkAlert("Invalid", message: "Password must be at least 8 characters and contain at least one capital letter and one number.", sender: self)
        } else {
            PFUser.logInWithUsernameInBackground(self.username.text!, password: self.password.text!, block: { (user, error) -> Void in
                if user != nil {
                    self.performSegueWithIdentifier("mainSegue", sender: self)
                } else {
                    displayOkAlert("Invalid", message: "Invalid login credentials.", sender: self)
                }
            })
        }
    }

}

