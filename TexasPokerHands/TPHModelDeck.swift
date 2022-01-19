//
//  TPHModelDeck.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHModelDeck {
    
    var cards = [TPHCard]()
    
    let capacity = 52
    
    init() {
        for thisSuit in TPHConstants.suits {
            for thisRank in TPHConstants.ranks {
                cards.append(
                    TPHCard(suit: thisSuit, rank: thisRank)
                )
            }
        }
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    func takeCards(number: Int) -> [TPHCard] {
        guard self.count >= number else {
            return []
        }
        var c = [TPHCard]()
        for _ in 1...number {
            let index = Int.random(in: 0...self.count)
            c.append(cards[index])
            cards.remove(at: index)
        }
        return c
    }
    
    var count: Int {
        return cards.count
    }
    
    var dealt: Int {
        return capacity - cards.count
    }
    
}
