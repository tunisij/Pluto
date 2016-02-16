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
    
}