//
//  TeamDataProvider.swift
//  Pluto
//
//  Created by John Tunisi on 2/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class TeamDataProvider {
    
    func findTeamsByUser(user: User?, completionHandler: (teams: Teams) -> ()) {
        if user == nil {
            return
        }
        
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/teams")
        var teams = Teams()
        
        ref.queryOrderedByChild("users/\(user!.uid)").queryEqualToValue(user?.uid).observeEventType(.Value, withBlock: { snapshot in
            
            for child in snapshot.children {
                let team = Team(snapshot: child as! FDataSnapshot)
                teams.append(team)
            }
            
            completionHandler(teams: teams)
        })
    }
    
    func findUsersByTeamKey(key: String, completionHandler: (user: User) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/teams/\(key)/users")
        let userModel = UserModel()
        
        ref.observeEventType(.Value, withBlock: { snapshot in

            for (key, _) in snapshot.value as! Dictionary<String, String> {
                userModel.getUserByKey(key, completionHandler: { (user) -> () in
                    completionHandler(user: user!)
                })
            }
        })
    }
}