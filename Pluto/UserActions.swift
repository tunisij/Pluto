//
//  UserActions.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase
import FBSDKLoginKit

func isUserLoggedIn() -> Bool {
    let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
    if ref.authData != nil {
        return true
    }
    return false
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

func deleteAccount(sender: AnyObject) {    
    let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
    ref.unauth()
    FBSDKLoginManager().logOut()
}