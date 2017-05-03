//
//  Pokemon.swift
//  PókeDex
//
//  Created by Mack Moynihan on 5/2/17.
//  Copyright © 2017 Mack Moynihan. All rights reserved.
//

import Foundation

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _ID: Int!
    var name: String {
        get {
            return _name
        } set {
            _name = newValue
        }
    }
    var ID: Int {
        get {
            return _ID
        } set {
            _ID = newValue
        }
    }
    
    
    init(name: String, pokedexID: Int){
        self.name = name
        self.ID = pokedexID
    }
}
