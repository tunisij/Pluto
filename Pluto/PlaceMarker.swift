//
//  PlaceMarker.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import GoogleMaps

class PlaceMarker: GMSMarker {
    let place: Place
    
    init(place: Place) {
        self.place = place
        super.init()
        
        position = place.coordinates
//        icon = UIImage(named: "Squads")
        groundAnchor = CGPoint(x: 0.5, y: 1)
    }
}

typealias PlaceMarkers = [PlaceMarker]