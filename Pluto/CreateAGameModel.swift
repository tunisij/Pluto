//
//  CreateAGameModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/9/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class CreateAGameModel {
    
    let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
    
    func persist(sportKey: String, startTime: NSDate, latitude: CLLocationDegrees, longitude: CLLocationDegrees, key: String) {
        
        //change to have user select which team to post as, and use team uid
        let game = Game(homeTeamKey: getUserUid(), awayTeamKey: "test", sportKey: sportKey, startTime: startTime, latitude: latitude, longitude: longitude, key: key)
        
        let gameRef = self.ref.childByAppendingPath(key)
        
        gameRef.setValue(game.toAnyObject())
    }
}