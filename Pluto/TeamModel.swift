//
//  CreateATeamModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class TeamModel {
    
    let userModel = UserModel()
    
    func persist(name: String, friends: Users, parent: UIViewController) -> String? {
        let teamRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/teams")
        let userRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
        let recordRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/records")
        
        if name.isEmpty {
            return "Must enter a team name"
        } else {
            userModel.getUser({ (user) in
                if user == nil {
                    return
                }
                
                let team = Team(name: name, captainKey: user!.uid, users: [user!.uid: user!.uid], recordKey: NSUUID().UUIDString, key: NSUUID().UUIDString)
                let record = Record(wins: 0, losses: 0, didNotShow: 0, rating: 0.0, key: NSUUID().UUIDString)
                
                let teamRef = teamRef.childByAppendingPath(team.key)
                let recordRef = recordRef.childByAppendingPath(team.recordKey)
                let userRef = userRef.childByAppendingPath(user!.uid).childByAppendingPath("teams").childByAppendingPath(team.key)
                
                teamRef.setValue(team.toAnyObject())
                recordRef.setValue(record.toAnyObject())
                
                userRef.setValue(team.key, withCompletionBlock: { (error:NSError?, ref:Firebase!) in
                    self.sendInvites(team.key, teamName: name, sender: user!.username, users: friends)
                })
            })
            
            return nil
        }
    }
    
    private func sendInvites(teamKey: String!, teamName: String!, sender: String!, users: Users) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/invites")
        
        for user in users {
            let invite = Invite(teamKey: teamKey, teamName: teamName, sender: sender, recipient: user.uid, key: NSUUID().UUIDString)
            ref.childByAppendingPath(invite.key).setValue(invite.toAnyObject())
        }
    }
    
    func acceptInvite(invite: Invite) {
        let teamRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/teams/\(invite.teamKey)/users")
        teamRef.updateChildValues([invite.recipient: invite.recipient])
        
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/invites/\(invite.key)")
        ref.removeValue()
    }
    
    func denyInvite(invite: Invite) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/invites/\(invite.key)")
        ref.removeValue()
    }
    
    private func createUserDictionary(users: Users) -> Dictionary<String, String> {
        var dictionary = [String: String]()
        
        for user in users {
            dictionary[user.uid] = user.uid
        }
        
        return dictionary
    }
}