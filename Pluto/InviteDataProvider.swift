//
//  InviteDataProvider.swift
//  Pluto
//
//  Created by John Tunisi on 3/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class InviteDataProvider {
    
    func findInvitesByUser(user: User?, completionHandler: (invites: Invites) -> ()) {
        if user == nil {
            return
        }
        
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/invites")
        var invites = Invites()
        
        if user == nil {
            return
        }
        
        ref.queryOrderedByChild("recipient").queryEqualToValue(user?.uid).observeEventType(.Value, withBlock: { snapshot in
            
            for child in snapshot.children {
                let invite = Invite(snapshot: child as! FDataSnapshot)
                invites.append(invite)
            }
            
            completionHandler(invites: invites)
        })
    }
}