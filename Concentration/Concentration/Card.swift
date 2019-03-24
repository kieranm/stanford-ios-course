//
//  Card.swift
//  Concentration
//
//  Created by Kieran McHugh on 23/03/2019.
//  Copyright © 2019 Kieran McHugh. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
