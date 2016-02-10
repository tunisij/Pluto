//
//  LoginModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/9/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase
import FBSDKLoginKit

class LoginModel {
    
    func login() {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"], handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                
            } else if facebookResult.isCancelled {
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                ref.authWithOAuthProvider("facebook", token: accessToken,
                    withCompletionBlock: { error, authData in
                        if error == nil {
                            //change to have user select which team to post as, and use team uid
                            let user = User(authData: ref.authData)
                            let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
                            
                            let userRef = ref.childByAppendingPath(user.uid)
                            
                            userRef.setValue(user.toAnyObject())
                        }
                })
            }
        })
    }
}