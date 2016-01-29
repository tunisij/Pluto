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
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        if section == 0 {
            rows = 2
        } else if section == 1 {
            rows = 1
        }
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            if PFUser.currentUser() == nil {
                if indexPath.row == 0 {
                    cell = tableView.dequeueReusableCellWithIdentifier("loginCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Login"
                } else if indexPath.row == 1 {
                    cell = tableView.dequeueReusableCellWithIdentifier("signupCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Sign up"
                }
            } else {
                if indexPath.row == 0 {
                    if indexPath.row == 0 {
                        cell = tableView.dequeueReusableCellWithIdentifier("resetPasswordCell", forIndexPath: indexPath)
                        cell.textLabel?.text = "Reset Password"
                    }
                } else if indexPath.row == 1 {
                    cell = tableView.dequeueReusableCellWithIdentifier("logoutCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Logout"
                }
            }
            
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCellWithIdentifier("legalCell", forIndexPath: indexPath)
            cell.textLabel?.text = "Legal"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if PFUser.currentUser() != nil {
                if indexPath.row == 1 {
                    PFUser.logOut()
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        
        if section == 0 {
            header = "Account Management"
        } else if section == 1 {
            header = "About"
        }
        return header
    }
    
}