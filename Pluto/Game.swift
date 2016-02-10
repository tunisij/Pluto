//
//  Game.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class Game {
    
    let key: String!
    let ref: Firebase?
    
    var sportKey: String!
    var startTime: NSDate!
    var latitude: Double!
    var longitude: Double!
    var homeTeamKey: String!
    var awayTeamKey: String!
    
    
    init(homeTeamKey: String, awayTeamKey: String = "", sportKey: String, startTime: NSDate, latitude: Double, longitude: Double, key: String = "") {
        self.key = key
        self.sportKey = sportKey
        self.startTime = startTime
        self.latitude = latitude
        self.longitude = longitude
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        homeTeamKey = snapshot.value["homeTeamKey"] as! String
        awayTeamKey = snapshot.value["awayTeamKey"] as! String
        sportKey = snapshot.value["sportKey"] as! String
        startTime = NSDate(timeIntervalSince1970: snapshot.value["startTime"] as! Double)
        latitude = snapshot.value["latitude"] as! Double
        longitude = snapshot.value["longitude"] as! Double
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "homeTeamKey": homeTeamKey,
            "awayTeamKey": awayTeamKey,
            "sportKey": sportKey,
            "startTime": startTime.timeIntervalSince1970,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}

typealias Games = [Game]