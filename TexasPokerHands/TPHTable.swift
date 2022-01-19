//
//  TPHTable.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHTable {
    
    var dealtCards = [TPHCard]()

    var burnt = [TPHCard]()

    public var currentGame: String {
        return dealtCards.spacedDescriptions
    }

    public var flop: String {
        guard dealtCards.count > 2 else { return "" }
        return dealtCards[0...2].spacedDescriptions
    }

    public var turn: String {
        guard dealtCards.count > 3 else { return "" }
        return dealtCards[3].description
    }

    public var river: String {
        guard dealtCards.count > 4 else { return "" }
        return dealtCards[4].description
    }

    func add(cards: [TPHCard]) {
        dealtCards += cards
    }

    func addToBurnt(card: TPHCard) {
        burnt.append(card)
    }

}
