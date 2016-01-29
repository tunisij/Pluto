//
//  SettingsTableViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/26/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Parse
import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        switch section {
        case 0:
            if !isUserLoggedIn() {
                rows = 3
            }
        case 1: rows = 1
        case 2:
            if isUserLoggedIn() {
                rows = 1
            }
        case 3:
            if isUserLoggedIn() {
                rows = 1
            }
        default: rows = 0
        }
        
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            if !isUserLoggedIn() {
                switch indexPath.row {
                case 0:
                    cell = tableView.dequeueReusableCellWithIdentifier("loginCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Login"
                case 1:
                    cell = tableView.dequeueReusableCellWithIdentifier("signupCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Sign up"
                case 2:
                    cell = tableView.dequeueReusableCellWithIdentifier("resetPasswordCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Reset Password"
                default: break
                    
                }
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("legalCell", forIndexPath: indexPath)
            cell.textLabel?.text = "Legal"
        case 2:
            if isUserLoggedIn() {
                cell = tableView.dequeueReusableCellWithIdentifier("logoutCell", forIndexPath: indexPath)
                cell.textLabel?.text = "Logout"
                cell.textLabel?.textAlignment = .Center
            }
        case 3:
            if isUserLoggedIn() {
                cell = tableView.dequeueReusableCellWithIdentifier("deleteAccountCell", forIndexPath: indexPath)
                cell.textLabel?.text = "Delete Account"
                cell.textLabel?.textAlignment = .Center
                cell.textLabel?.textColor = UIColor.redColor()
            }
        default: break
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            if isUserLoggedIn() {
                attemptLogout("Logout", message: "Are you sure you want to logout?", sender: self)
            }
        } else if indexPath.section == 3 {
            if isUserLoggedIn() {
                attemptDelete("Delete Account", message: "Are you sure you want to delete the account?", sender: self)
            }
        }
    }
    
}