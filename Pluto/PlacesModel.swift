//
//  PlacesModel.swift
//  Pluto
//
//  Created by John Tunisi on 2/15/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class PlacesModel {
    
    func createPlaceMarkers(games: Games) -> PlaceMarkers {
        var placeMarkers = PlaceMarkers()
        
        for game in games {
            let placeMarker = PlaceMarker(latitude: game.latitude, longitude: game.longitude)
            placeMarkers.append(placeMarker)
        }
        
        return placeMarkers
    }
}