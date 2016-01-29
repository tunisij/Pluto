//
//  Record.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Record {
    
    var identifier: Int
    var wins: Dictionary<Sport, Int>
    var losses: Dictionary<Sport, Int>
    var didNotShow: Int
    var rating: Double
    
    init(identifier: Int, wins: Dictionary<Sport, Int>, losses: Dictionary<Sport, Int>, didNotShow: Int, rating: Double) {
        self.identifier = identifier
        self.wins = wins
        self.losses = losses
        self.didNotShow = didNotShow
        self.rating = rating
    }
    
    func getRecord() -> String {
        return "\(wins) - \(losses)"
    }
    
    func getDidNotShowPercent() -> Double {
        var totalWins = 0
        var totalLosses = 0
        
        for winAmount in wins.values {
            totalWins += winAmount
        }
        
        for lossAmount in losses.values {
            totalLosses += lossAmount
        }
        
        return Double(didNotShow) / Double(totalWins + totalLosses)
    }
    
    
    
}