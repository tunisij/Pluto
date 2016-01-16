//
//  SettingsViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/15/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    @IBAction func logoutButtonClicked(sender: UIButton) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
}