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
        facebookLogin.logInWithReadPermissions(["user_friends, public_profile, email"], handler: {
            (facebookResult, facebookError) -> Void in
            if facebookError != nil {
                
            } else if facebookResult.isCancelled {
                
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    if error == nil {
                            
                        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name"] )
                        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                            
                            if ((error) == nil) {
                                let email = result.valueForKey("email") as? String
                                let username = result.valueForKey("name") as? String
                                
                                let user = User(authData: ref.authData, username: username!, email: email!)
                                let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
                                
                                let userRef = ref.childByAppendingPath(user.uid)
                                
                                userRef.setValue(user.toAnyObject())
                            }    
                        })
                    }
                })
            }
        })
    }
    
    func loginHelper() {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com")
        let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
        
        ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
            if error == nil {
                
                let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name"] )
                graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                    
                    if ((error) == nil) {
                        let email = result.valueForKey("email") as? String
                        let username = result.valueForKey("name") as? String
                        
                        let user = User(authData: ref.authData, username: username!, email: email!)
                        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
                        
                        let userRef = ref.childByAppendingPath(user.uid)
                        
                        userRef.setValue(user.toAnyObject())
                    }
                })
            }
        })

    }
    
}