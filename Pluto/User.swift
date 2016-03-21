//
//  Profile.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class User: Hashable {
    
    var uid: String
    var username: String!
    var email: String!
    var teams: Dictionary<String, String>?
    
    var hashValue: Int {
        return "uid".hashValue
    }
    
    init(authData: FAuthData, username: String = "", email: String = "", teams: Dictionary<String, String>) {
        self.uid = authData.uid
        self.username = username
        self.email = email
        self.teams = teams
    }
    
    init(snapshot: FDataSnapshot) {
        uid = snapshot.value["uid"] as! String
        username = snapshot.value["username"] as! String
        email = snapshot.value["email"] as! String
        teams = snapshot.value["teams"] as? Dictionary<String, String>
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "uid": uid,
            "username": username,
            "email": email,
            "teams": teams!
        ]
    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

typealias Users = [User]