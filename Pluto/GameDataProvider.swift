//
//  GameDataProvider.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Parse

class GameDataProvider {
    
    func findAllGames(completionHandler: (games: Games) -> ()) {
        let query = PFQuery(className: "Game")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            var games = Games()
            
            if error == nil {
                if let objects = objects {
                    for gameObject in objects {
                        let sport = gameObject["sport"] as! String
                        let startTime = gameObject["startTime"] as! NSDate
                        let pfGeoPoint = gameObject["gameLocation"] as! PFGeoPoint
                        let coordinates = CLLocationCoordinate2D(latitude: pfGeoPoint.latitude, longitude: pfGeoPoint.longitude)
                        games.append(Game(sport: sport, startTime: startTime, coordinates: coordinates))
                    }
                    completionHandler(games: games)
                }
            }
        }
    }
    
}