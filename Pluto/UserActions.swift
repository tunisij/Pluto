//
//  UserActions.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Parse

func isUserLoggedIn() -> Bool {
    return PFUser.currentUser() != nil
}

func logout(sender: AnyObject) {
    PFUser.logOut()
}

func deleteAccount(sender: AnyObject) {    
    print("Delete account needs to be implemented")
}