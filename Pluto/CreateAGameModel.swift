//
//  CreateAGameModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/9/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class CreateAGameModel {
    
    let gameRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
    let userRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
    
    func persist(sportKey: String, startTime: NSDate, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String? {

        if sportKey.isEmpty {
            return "Must enter a sport"
        } else if startTime.compare(NSDate()) != .OrderedDescending {
            return "Time must be set in the future"
        } else if latitude == 0.0 && longitude == 0.0 {
            return "Location invalid"
        } else if !isUserLoggedIn() {
            return "Login to post a game"
        } else {
            let game = Game(homeTeamKey: getUserUid(), awayTeamKey: "test", sportKey: sportKey, startTime: startTime, latitude: latitude, longitude: longitude, key: NSUUID().UUIDString)
            
            let gameRef = self.gameRef.childByAppendingPath(game.key)
            let userRef = self.userRef.childByAppendingPath(getUserUid()).childByAppendingPath("games").childByAppendingPath(game.key)
            
            gameRef.setValue(game.toAnyObject())
            userRef.setValue(game.key)
            return nil
        }
    }
}