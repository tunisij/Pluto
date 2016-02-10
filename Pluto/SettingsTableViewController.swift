//
//  SettingsTableViewController.swift
//  Pluto
//
//  Created by John Tunisi on 1/26/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class SettingsTableViewController: UITableViewController {
    
    let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
    
    let model = LoginModel()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        switch section {
        case 0:
            if isUserLoggedIn() {
                rows = 1
            }
            rows = 2
        case 1:
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
            switch indexPath.row {
            case 0:
                if !isUserLoggedIn() {
                    cell = tableView.dequeueReusableCellWithIdentifier("facebookLoginCell", forIndexPath: indexPath)
                    cell.textLabel?.text = "Login With Facebook"
                }
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier("legalCell", forIndexPath: indexPath)
                cell.textLabel?.text = "Legal"
            default: break
            }
        case 1:
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
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if !isUserLoggedIn() {
                    model.login()
                }
            default: break
            }
            
        case 1:
            if isUserLoggedIn() {
                attemptDelete("Delete Account", message: "Are you sure you want to delete the account? This will delete all data associated with this Facebook account.", sender: self)
            }
        default: break
        }
    }
    
}