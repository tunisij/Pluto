//
//  CreateAGameModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/9/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class GameModel {
    
    let userModel = UserModel()
    
    func persist(sportKey: String, startTime: NSDate, team: Team, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> String? {
        let gameRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
        let userRef = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/users")
        
        if sportKey.isEmpty {
            return "Must enter a sport"
        } else if startTime.compare(NSDate()) != .OrderedDescending {
            return "Time must be set in the future"
        } else if latitude == 0.0 && longitude == 0.0 {
            return "Location invalid"
        } else if !userModel.isUserLoggedIn() {
            return "Login to post a game"
        } else {
            let game = Game(homeTeamKey: team.key, awayTeamKey: "test", sportKey: sportKey, startTime: startTime, latitude: latitude, longitude: longitude, key: NSUUID().UUIDString)
            
            let gameRef = gameRef.childByAppendingPath(game.key)
            let userRef = userRef.childByAppendingPath(userModel.getUserUid()).childByAppendingPath("games").childByAppendingPath(game.key)
            
            gameRef.setValue(game.toAnyObject())
            userRef.setValue(game.key)
            return nil
        }
    }
}