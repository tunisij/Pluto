//
//  SettingsContainerViewController.swift
//  Pluto
//
//  Created by John Tunisi on 2/5/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SettingsContainerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var facebookLoginView: UIView!

    
    override func viewDidLoad() {
        let facebookButton = FBSDKLoginButton()
        facebookLoginView.addSubview(facebookButton)
        facebookLoginView.center = facebookButton.center
        facebookButton.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        switch section {
        case 0: rows = 1
        case 1:
            if isUserLoggedIn() {
                rows = 1
            }
        default: rows = 0
        }
        
        return rows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
//        case 0:
//            cell = tableView.dequeueReusableCellWithIdentifier("facebookLoginCell", forIndexPath: indexPath)
//            
//            let loginView : FBSDKLoginButton = FBSDKLoginButton()
//            cell.contentView.addSubview(loginView)
//            loginView.center = cell.contentView.center
//            loginView.readPermissions = ["public_profile", "email", "user_friends"]
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("legalCell", forIndexPath: indexPath)
            cell.textLabel?.text = "Legal"
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if isUserLoggedIn() {
//                attemptDelete("Delete Account", message: "Are you sure you want to delete the account?", sender: self.tableView)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
    }
}