//
//  Game.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Game {
    
    var identifier: Int
    var sport: Sport
    var startTime: NSDate
    var coordinates: CLLocationCoordinate2D
    
    init(identifier: Int, sport: Sport, startTime: NSDate, coordinates: CLLocationCoordinate2D) {
        self.identifier = identifier
        self.sport = sport
        self.startTime = startTime
        self.coordinates = coordinates
    }
}

typealias Games = [Game]