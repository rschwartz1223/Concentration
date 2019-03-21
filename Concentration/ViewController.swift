//
//  ViewController.swift
//  Concentration
//
//  Created by Robert Schwartz on 3/4/19.
//  Copyright © 2019 Robert Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int
    {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0
    {
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()

        }
        else
        {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else
            {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5135931373, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5135931373, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = "👻🎃👺💀🤖🤡🕷🍫🍭"

    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String
    {
        if emoji[card] == nil, emojiChoices.count > 0
        {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))

        }
        return emoji[card] ?? "?"
    }
}

extension Int
{
    var arc4random: Int
    {
        switch self
        {
            case 1...Int.max:
                return Int(arc4random_uniform(UInt32(self)))
            case -Int.max..<0:
                return Int(arc4random_uniform(UInt32(self)))
            default:
                return 0
        }
    }
}
