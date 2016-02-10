//
//  PlaceMarker.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import GoogleMaps

class PlaceMarker: GMSMarker {
    let latitude: Double!
    let longitude: Double!
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init()
        
        position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        icon = UIImage(named: "Squads")
        groundAnchor = CGPoint(x: 0.5, y: 1)
    }
}

typealias PlaceMarkers = [PlaceMarker]