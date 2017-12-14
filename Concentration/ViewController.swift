//
//  ViewController.swift
//  Concentration
//
//  Created by Dumitru Gutu on 12/12/17.
//  Copyright © 2017 Dumitru Gutu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var restartGameButton: UIButton!
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var numberOfMatchedCars = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartGameButton.isHidden = true
    }
    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            countMatchedCards()
        }
        if numberOfMatchedCars >= (numberOfPairsOfCards * 2) {
            restartGameButton.isHidden = false
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        for index in cardButtons.indices {
            var card = game.cards[index]
            card.isFaceUp = false
            card.isMatched = false
            print(card)
            flipCount = 0
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func countMatchedCards() {
        for index in cardButtons.indices {
            let card = game.cards[index]
            if card.isMatched && card.isFaceUp {
                numberOfMatchedCars += 1
            }
        }
    }
    
//    private var emojiChoices = ["🦇", "😱", "😈", "🤡", "🐶", "👀", "👻", "🎃", "👾"]
    private var emojiChoices = "🦇😱😈🤡🐶👀👻🎃👾"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}



