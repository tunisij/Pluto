//
//  TeamDataProvider.swift
//  Pluto
//
//  Created by John Tunisi on 2/22/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class TeamDataProvider {
    func findAllTeams(completionHandler: (teams: Teams) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/teams")
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            var teams = Teams()
            
            for gameSnap in snapshot.children {
                
                let team = Team(snapshot: gameSnap as! FDataSnapshot)
                teams.append(team)
            }
            completionHandler(teams: teams)
        })
    }
    
//    func findGamesNearby(latitude: CLLocationDegrees?, longitude: CLLocationDegrees?, completionHandler: (games: Games) -> ()) {
//        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
//        
//        if latitude == nil || longitude == nil {
//            return
//        }
//        
//        ref.queryOrderedByChild("latitude").queryStartingAtValue(latitude! - 0.3).queryEndingAtValue(latitude! + 0.3).observeEventType(.Value, withBlock: { snapshot in
//            var games = Games()
//            
//            for child in snapshot.children {
//                let game = Game(snapshot: child as! FDataSnapshot)
//                
//                if game.longitude >= longitude! - 0.3 && game.longitude <= longitude! + 0.3 {
//                    games.append(game)
//                }
//            }
//            
//            completionHandler(games: games)
//        })
//    }
//    
//    func findGames(user: User?, completionHandler: (games: Games) -> ()) {
//        if user == nil {
//            return
//        }
//        
//        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
//        var games = Games()
//        
//        ref.queryOrderedByChild("homeTeamKey").queryEqualToValue(user?.uid).observeEventType(.Value, withBlock: { snapshot in
//            
//            for child in snapshot.children {
//                let game = Game(snapshot: child as! FDataSnapshot)
//                games.append(game)
//            }
//            
//            completionHandler(games: games)
//        })
//        
//    }
    
}