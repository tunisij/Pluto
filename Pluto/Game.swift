//
//  Game.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Game {
    
    let sport: String
    let startTime: NSDate
    let coordinates: CLLocationCoordinate2D
    
    init(sport: String, startTime: NSDate, coordinates: CLLocationCoordinate2D) {
        self.sport = sport
        self.startTime = startTime
        self.coordinates = coordinates
    }
}

typealias Games = [Game]