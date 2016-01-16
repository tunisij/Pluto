//
//  LoginFunctions.swift
//  Pluto
//
//  Created by John Tunisi on 1/12/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit

func displayOkAlert(title: String, message: String, sender: AnyObject) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alert.addAction(defaultAction)
    sender.presentViewController(alert, animated: true, completion: nil)
}