//
//  CreateATeamModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class CreateATeamModel {
    
    let teamRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/teams")
    let userRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
    let recordRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/records")
    
    func persist(name: String) -> String? {
        
        if name.isEmpty {
            return "Must enter a team name"
        } else {
            let team = Team(name: name, captainKey: getUserUid(), usersKey: "", recordKey: NSUUID().UUIDString, key: NSUUID().UUIDString)
            let record = Record(wins: 0, losses: 0, didNotShow: 0, rating: 0.0, key: NSUUID().UUIDString)
           
            let teamRef = self.teamRef.childByAppendingPath(team.key)
            let recordRef = self.recordRef.childByAppendingPath(team.recordKey)
            let userRef = self.userRef.childByAppendingPath(getUserUid()).childByAppendingPath("teams").childByAppendingPath(team.key)
            
            teamRef.setValue(team.toAnyObject())
            recordRef.setValue(record.toAnyObject())
            userRef.setValue(team.key)
            return nil
        }
    }
}