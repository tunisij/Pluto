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
    
    init(authData: FAuthData) {
        self.uid = authData.uid
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "uid": uid
        ]
    }
    
}

typealias Users = [User]