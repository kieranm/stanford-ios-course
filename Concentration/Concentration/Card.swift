//
//  Card.swift
//  Concentration
//
//  Created by Kieran McHugh on 23/03/2019.
//  Copyright © 2019 Kieran McHugh. All rights reserved.
//

import Foundation

// A Card models a tappable card object.
struct Card {
    // isFaceUp indicates whether at this point in time the card
    // has its emoji visible on screen or now.
    var isFaceUp = false
    
    // isMatched indicates if the user has successfully matched
    // this card with its counterpart and therefore whether it should
    // be removed from the game.
    var isMatched = false
    
    // identifier is a numeric ID for this card. It will be shared
    // by one other card. It's used to determine which emoji to assign
    // to the card, as well as equality comparison during gameplay.
    var identifier: Int
    
    // identifierFactory is a static (class) variable to keep track
    // of IDs assigned to different cards as they are instantiated.
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // When a card is created we generate an ID for it.
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
