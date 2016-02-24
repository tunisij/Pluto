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

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    
    let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
    let model = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fbButton = FBSDKLoginButton()
        fbButton.delegate = self
        
        bottomView.addSubview(fbButton)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
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
        switch indexPath.section {
        case 1:
            if isUserLoggedIn() {
                attemptDelete("Delete Account", message: "Are you sure you want to delete the account? This will delete all data associated with this Facebook account.", sender: self.tableView, parent: self)
            }
        default: break
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if !result.isCancelled {
            model.loginHelper()
        }
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        ref.unauth()
    }
    
}