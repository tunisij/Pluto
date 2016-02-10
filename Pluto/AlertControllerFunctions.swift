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

//func attemptLogout(title: String, message: String, sender: UITableViewController) {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
//    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//    let logoutAction = UIAlertAction(title: "Logout", style: .Destructive, handler: { (action: UIAlertAction!) in
//        logout(sender)
//        sender.tableView.reloadData()
//    })
//    alert.addAction(cancelAction)
//    alert.addAction(logoutAction)
//    sender.presentViewController(alert, animated: true, completion: nil)
//}

func attemptDelete(title: String, message: String, sender: UITableViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action: UIAlertAction!) in
        deleteAccount(sender)
        sender.tableView.reloadData()
    })
    alert.addAction(cancelAction)
    alert.addAction(deleteAction)
    sender.presentViewController(alert, animated: true, completion: nil)
}