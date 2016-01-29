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
                        let identifier = gameObject["identifier"] as! Int
                        let sportName = gameObject["sport"] as! String
                        let startTime = gameObject["startTime"] as! NSDate
                        let pfGeoPoint = gameObject["gameLocation"] as! PFGeoPoint
                        
                        //Take actual sport identifier when I switch BaaS
                        let sport = Sport(identifier: identifier, name: sportName)
                        let coordinates = CLLocationCoordinate2D(latitude: pfGeoPoint.latitude, longitude: pfGeoPoint.longitude)
                        games.append(Game(identifier: identifier, sport: sport, startTime: startTime, coordinates: coordinates))
                    }
                    completionHandler(games: games)
                }
            }
        }
    }
    
}