
//
//  PlaceDataProvider.swift
//  Pluto
//
//  Created by John Tunisi on 1/26/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Parse

class PlacesModel {
    
    func createPlaces(games: Games) -> Places {
        var places = Places()
        for game in games {
            places.append(Place(sport: game.sport, coordinates: game.coordinates, image: UIImage()))
        }
        return places
    }
    
    func createPlaceMarkers(places: Places) -> PlaceMarkers {
        var placeMarkers = PlaceMarkers()
        
        for place in places {
            placeMarkers.append(PlaceMarker(place: place))
        }
        return placeMarkers
    }
}