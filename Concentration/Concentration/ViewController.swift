//
//  ViewController.swift
//  Concentration
//
//  Created by Kieran McHugh on 16/03/2019.
//  Copyright © 2019 Kieran McHugh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        // When the flip count changes, we will use an observer to
        // also update the flip count label on the screen.
        didSet {
            flipCountLabel.text = "\(flipCount) Flips"
        }
    }

    // Label at the bottom of the screen
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // cardButtons is an array of UI buttons, one for each card.
    @IBOutlet var cardButtons: [UIButton]!
    
    // Initialise an instance of the Concentration model
    // Since this depends on the number of cardButtons (another instance
    // variable), this needs to be lazily evaluated after initialisation
    // of the controller. This makes it impossible to use observers like didSet.
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    // touchCard is dispatched whenever one of the cards is tapped
    @IBAction func touchCard(_ sender: UIButton) {
        // Increment the flip count
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            // Call out to the game model to update the game state
            game.chooseCard(at: cardNumber)
            // Then update the view to reflect the model
            updateViewFromModel()
        }
    }
    
    // updateViewFromModel changes the display of the cards
    // depending on the model's current state
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    // emojiChoices is a set from which the cards will draw emoji to be displayed
    // on their reverse side.
    var emojiChoices = ["🎃", "👻", "👽", "🎩", "👑", "👓", "🦆", "🐋"]
    // This could also be written var emoji = Dictionary<Int,String>()
    var emoji = [Int:String]()
    
    // emoji checks if an emoji has already been assigned for cards
    // with this ID. If so, it returns that emoji.
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // This is probably overkill since all of the cards are shuffled
            // anyway but gotta follow that tutorial ¯\_(ツ)_/¯
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        // The special `??` syntax checks if the value of the optional is
        // nil, and if so returns a default value, in this case a "?"
        return emoji[card.identifier] ?? "?"
    }
}
