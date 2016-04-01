//
//  File.swift
//  Pluto
//
//  Created by John Tunisi on 3/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase
import FBSDKLoginKit

class UserModel {
    
    func isUserLoggedIn() -> Bool {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
        return ref.authData == nil ? false : true
    }
    
    func getUserUid() -> String! {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
        if ref.authData != nil {
            if ref.authData.uid != nil {
                return ref.authData.uid
            }
        }
        return ""
    }
    
    func getUser(completionHandler: (user: User?) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
        var user: User?
        
        ref.queryOrderedByChild("uid").queryEqualToValue(getUserUid()).observeSingleEventOfType(.Value, withBlock: { snapshot in
            for child in snapshot.children {
                user = User(snapshot: child as! FDataSnapshot)
            }
            
            completionHandler(user: user)
        })
    }
    
    func getUserByKey(key: String, completionHandler: (user: User?) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
        var user: User?
        
        ref.queryOrderedByChild("uid").queryEqualToValue(key).observeSingleEventOfType(.Value, withBlock: { snapshot in
            for child in snapshot.children {
                user = User(snapshot: child as! FDataSnapshot)
            }
            
            completionHandler(user: user)
        })
        
    }
    
    func getUserByEmail(email: String!, completionHandler: (user: User?) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
        var user: User?
        
        ref.queryOrderedByChild("email").queryEqualToValue(email).observeSingleEventOfType(.Value, withBlock: { snapshot in
            for child in snapshot.children {
                user = User(snapshot: child as! FDataSnapshot)
            }
            
            completionHandler(user: user)
        })
    }
    
    func deleteAccount(sender: AnyObject) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users/\(getUserUid())")
        ref.removeValue()
        ref.unauth()
        FBSDKLoginManager().logOut()
    }
}