//
//  GameDataProvider.swift
//  Pluto
//
//  Created by John Tunisi on 1/25/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class GameDataProvider {
    
    func findAllGames(completionHandler: (games: Games) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            var games = Games()
            
            for gameSnap in snapshot.children {
                
                let game = Game(snapshot: gameSnap as! FDataSnapshot)
                games.append(game)
            }
            completionHandler(games: games)
        })
    }
    
    func findGamesNearby(latitude: CLLocationDegrees?, longitude: CLLocationDegrees?, completionHandler: (games: Games) -> ()) {
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
        
        if latitude == nil || longitude == nil {
            return
        }
        
        ref.queryOrderedByChild("latitude").queryStartingAtValue(latitude! - 0.3).queryEndingAtValue(latitude! + 0.3).observeEventType(.Value, withBlock: { snapshot in
            var games = Games()
            
            for child in snapshot.children {
                let game = Game(snapshot: child as! FDataSnapshot)
                
                if game.longitude >= longitude! - 0.3 && game.longitude <= longitude! + 0.3 {
                    
                    if game.startTime.isGreaterThanDate(NSDate().addHours(-3)) {
                        games.append(game)
                    }
                }
            }

            completionHandler(games: games)
        })
    }
    
    func findUpcomingGames(user: User!, completionHandler: (games: Games) -> ()) {
        let teamDataProvider = TeamDataProvider()
        
        teamDataProvider.findTeamsByUser(user!) { (teams) -> () in
            for team in teams {
                let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
                
                ref.queryOrderedByChild("homeTeamKey").queryEqualToValue(team.key).observeSingleEventOfType(.Value, withBlock: { snapshot in
                    var games = Games()
                    
                    for child in snapshot.children {
                        let game = Game(snapshot: child as! FDataSnapshot)
                        
                        if !game.startTime.isLessThanDate(NSDate()) {
                            games.append(game)
                        }
                    }
                    
                    completionHandler(games: games)
                })
            }
        }
    }
    
    func findPreviousGames(user: User!, completionHandler: (games: Games) -> ()) {
        let teamDataProvider = TeamDataProvider()
        
        teamDataProvider.findTeamsByUser(user!) { (teams) -> () in
            for team in teams {
                let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
                
                ref.queryOrderedByChild("homeTeamKey").queryEqualToValue(team.key).observeSingleEventOfType(.Value, withBlock: { snapshot in
                    var games = Games()
                    
                    for child in snapshot.children {
                        let game = Game(snapshot: child as! FDataSnapshot)
                        
                        if game.startTime.isLessThanDate(NSDate()) {
                            games.append(game)
                        }
                    }
                    
                    completionHandler(games: games)
                })
            }
        }
        
    }
    
    func findGames(user: User?, completionHandler: (games: Games) -> ()) {
        if user == nil {
            return
        }
        
        let ref = Firebase(url: "https://edu-gvsu-pluto.firebaseio.com/games")
        var games = Games()
        
        ref.queryOrderedByChild("homeTeamKey").queryEqualToValue(user?.uid).observeEventType(.Value, withBlock: { snapshot in
            
            for child in snapshot.children {
                let game = Game(snapshot: child as! FDataSnapshot)
                games.append(game)
            }
            
            completionHandler(games: games)
        })
        
    }
    
    
    
}