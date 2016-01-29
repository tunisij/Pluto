//
//  GooglePlace.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//


class Place {
    
    var coordinates: CLLocationCoordinate2D
    var sport: Sport
    var image: UIImage
    
    init(sport: Sport, coordinates: CLLocationCoordinate2D, image: UIImage) {
        self.coordinates = coordinates
        self.sport = sport
        self.image = image
    }
    
}

typealias Places = [Place]