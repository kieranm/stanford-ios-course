//
//  Concentration.swift
//  Concentration
//
//  Created by Kieran McHugh on 23/03/2019.
//  Copyright © 2019 Kieran McHugh. All rights reserved.
//

// This is a model, not a UI
// We are therefore importing Foundation instead of UIView
import Foundation

class Concentration {
    // Create an array of cards using the shorthand notation
    // We could also do var cards = Array<Card>()
    var cards = [Card]()
    
    // Not a very scalable approach but it works here. When a card is turned over
    // we record its index in the array of cards here. Then, when a second card is
    // turned over, we compare it with the card at this index.
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            // Create a new card object
            let card = Card()
            
            // We need to add a pair of cards
            // Note that both of these cards have the same identifier, this
            // identifier will be used to assign an emoji and also to compare
            // the cards for equality when they are tapped.
            // Important: Since Card is in fact a struct (not a class), we're creating
            // two copies of the object here and not simply two references to the same
            // object. This is important because it allows us to flip the cards over
            // independently (they both have their own isMatched/isFaceUp attributes.
            cards += [card, card]
        }
        
        // We need to shuffle the cards as otherwise their positions
        // would be very predictable!
        cards.shuffle()
    }
    
    // chooseCard is called when a card is tapped.
    func chooseCard(at index: Int) {
        // If this card has already been matched then it is transparent
        // on the screen and tapping it shouldn't do anything.
        if cards[index].isMatched {
            return
        }
        
        // We also need to make sure that the card that has been tapped is not the
        // same as the card in the `indexOfOneAndOnlyFaceUpCard`.
        // If it is, then this means that the same card has been tapped twice and
        // therefore we shouldn't do anything.
        if indexOfOneAndOnlyFaceUpCard == index {
            return
        }

        // Check if a card has already been turned over. If it has then we need
        // to do a comparison.
        if let matchIndex = indexOfOneAndOnlyFaceUpCard {
            // If the cards both have the same ID then they will both have
            // the same emoji and therefore we can set them both to matched
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            // Since the card has been tapped we need to set it to face up
            cards[index].isFaceUp = true
            
            // We now have two cards facing up so we need to set this index
            // to nil and return.
            indexOfOneAndOnlyFaceUpCard = nil
            return
        }
        
        // Either no cards or two cards are facing up. We will set all the cards
        // to face down (this could be a no-op) and then one card to face up.
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = index
    }
}
