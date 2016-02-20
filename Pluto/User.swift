//
//  Profile.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class User {
    
    var uid: String
    var username: String!
    var email: String!
    
    init(authData: FAuthData, username: String = "", email: String = "") {
        self.uid = authData.uid
        self.username = username
        self.email = email
    }
    
    init(snapshot: FDataSnapshot) {
        uid = snapshot.value["uid"] as! String
        username = snapshot.value["username"] as! String
        email = snapshot.value["email"] as! String
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "uid": uid,
            "username": username,
            "email": email
        ]
    }
    
}

typealias Users = [User]