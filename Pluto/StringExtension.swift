//
//  StringExtension.swift
//  Pluto
//
//  Created by John Tunisi on 1/12/16.
//  Copyright © 2016 John Tunisi. All rights reserved.
//


extension String {
    
    func guaranteeString() -> String {
        return (self ?? "").isEmpty ? "" : self
    }
}