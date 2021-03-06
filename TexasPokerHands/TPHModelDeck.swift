//
//  TPHModelDeck.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHModelDeck {
    
    // Use TPHDealer to manipulate the deck.
    
    public var cards = [TPHCard]()
    
    public var capacity = 52
    
    public init() {
        for thisSuit in TPHConstants.suits {
            for thisRank in TPHConstants.ranks {
                cards.append(
                    TPHCard(suit: thisSuit, rank: thisRank)
                )
            }
        }
    }
    
    public func shuffle() {
        cards.shuffle()
    }
    
    // The dealer takes random cards from the ordered stack. Another option, closer to reality, would have been to shuffle the stack then to take cards from the top. You can still shuffle at any time if you want to prevent tempering or collisions.
    public func takeCards(number: Int) -> [TPHCard] {
        guard self.count >= number else {
            return []
        }
        var c = [TPHCard]()
        for _ in 1...number {
            let index = Int.random(in: 0...self.count - 1)
            c.append(cards[index])
            cards.remove(at: index)
        }
        return c
    }
    
    public var count: Int {
        return cards.count
    }
    
    public var dealt: Int {
        return capacity - cards.count
    }
    
}
