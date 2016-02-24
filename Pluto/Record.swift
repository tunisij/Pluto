//
//  Record.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

import Firebase

class Record {
    
    let key: String!
    let ref: Firebase?
    
    var wins: Int!
    var losses: Int!
    var didNotShow: Int!
    var rating: Double!
    
    init(wins: Int, losses: Int, didNotShow: Int, rating: Double, key: String = "") {
        self.key = key
        self.wins = wins
        self.losses = losses
        self.didNotShow = didNotShow
        self.rating = rating
        self.ref = nil
    }
    
    init(snapshot: FDataSnapshot) {
        key = snapshot.key
        wins = snapshot.value["wins"] as! Int
        losses = snapshot.value["losses"] as! Int
        didNotShow = snapshot.value["didNotShow"] as! Int
        rating = snapshot.value["rating"] as! Double
        ref = nil
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "wins": wins,
            "losses": losses,
            "didNotShow": didNotShow,
            "rating": rating
        ]
    }
    
//    func getRecord() -> String {
//        return "\(wins) - \(losses)"
//    }
//    
//    func getDidNotShowPercent() -> Double {
//        var totalWins = 0
//        var totalLosses = 0
//        
//        for winAmount in wins.values {
//            totalWins += winAmount
//        }
//        
//        for lossAmount in losses.values {
//            totalLosses += lossAmount
//        }
//        
//        return Double(didNotShow) / Double(totalWins + totalLosses)
//    }
    
}