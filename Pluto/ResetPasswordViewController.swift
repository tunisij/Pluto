//
//  ResetPasswordViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/15/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        
        emailAddressTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailAddressTextField {
            if validateEmailAddress(emailAddressTextField.text!) {
                textField.resignFirstResponder()
                resetPasswordButtonClicked(emailAddressTextField)
            }
        }
        return true
    }
    
    @IBAction func resetPasswordButtonClicked(sender: AnyObject) {
        PFUser.requestPasswordResetForEmailInBackground(emailAddressTextField.text!)
    }
    
}