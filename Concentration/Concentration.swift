//
//  Concentration.swift
//  Concentration
// 
//  Created by Robert Schwartz on 3/5/19.
//  Copyright © 2019 Robert Schwartz. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    {
        get
        {
            var foundIndex: Int?
            for index in cards.indices
            {
                if cards[index].isFaceUp
                {
                    if foundIndex == nil
                    {
                        foundIndex = index
                    }
                    else
                    {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set
        {
            for index in cards.indices
            {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int)
    {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
                //check if cards match
                if cards[matchIndex] == cards[index]
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else
            {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int)
    {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
        //Shuffle the cards
        for number in 1...cards.count
        {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count - number)))
            cards.append(cards.remove(at: randomIndex))
        }
    }
}

