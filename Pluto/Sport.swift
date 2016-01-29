//
//  Sport.swift
//  Pluto
//
//  Created by John Tunisi on 1/29/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//

class Sport: Hashable {
    
    var identifier: Int
    var name: String
    
    var hashValue: Int {
        return self.identifier
    }
    
    init(identifier: Int, name: String) {
        self.identifier = identifier
        self.name = name
    }
    
}

func ==(lhs: Sport, rhs: Sport) -> Bool {
    return lhs.identifier == rhs.identifier
}

typealias Sports = [Sport]