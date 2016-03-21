//
//  Invite.swift
//  Pluto
//
//  Created by John Tunisi on 3/20/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//


import Firebase

class Invite {
    
    let key: String!
    let ref: Firebase?
    
    var teamKey: String!
    var teamName: String!
    var sender: String!
    var recipient: String!
    
    init(teamKey: String, teamName: String!, sender: String, recipient: String, key: String = "") {
        self.key = key
        self.teamKey = teamKey
        self.teamName = teamName
        self.sender = sender
        self.recipient = recipient
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        teamKey = snapshot.value["teamKey"] as! String
        teamName = snapshot.value["teamName"] as! String
        sender = snapshot.value["sender"] as! String
        recipient = snapshot.value["recipient"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "teamKey": teamKey,
            "teamName": teamName,
            "sender": sender,
            "recipient": recipient
        ]
    }
}

typealias Invites = [Invite]