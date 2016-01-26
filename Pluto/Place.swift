//
//  GooglePlace.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//


class Place {
    
    var coordinates: CLLocationCoordinate2D
    var sport: String
    
    init(sport: String, coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
        self.sport = sport
    }
    
}

typealias Places = [Place]