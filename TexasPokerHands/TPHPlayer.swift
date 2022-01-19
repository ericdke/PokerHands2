//
//  TPHPlayer.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHPlayer {
    
    let id = UUID()

    public init(name: String? = nil) {
        self.name = name ?? ""
    }
    
    var name: String?

    var historyOfDealtCards = [TPHPocketCard]()
    
    var frequentHands = [String:Int]()

    var hand: TPHHand?
    
    var handDescription: String? {
        return hand?.cards.joined(separator: " ")
    }
    
    var handNameDescription: String? {
        return hand?.rank.name.rawValue.lowercased()
    }

    var cardsHistory: String {
        let mapped = historyOfDealtCards.map { $0.card1.description + " " + $0.card2.description }
        return mapped.joined(separator: ", ")
    }

    var cards = [TPHCard]() {
        didSet {
            let tu = TPHPocketCard(card1: cards[0], card2: cards[1], date: Date())
            historyOfDealtCards.append(tu)
            let fqname = "\(tu.card1.description),\(tu.card2.description)"
            if frequentHands[fqname] == nil {
                frequentHands[fqname] = 1
            } else {
                frequentHands[fqname]! += 1
            }
        }
    }

    var cardsNames: String {
        return cards.joinNames(with: ", ")
    }

    var count: Int {
        return cards.count
    }

    var holeCards: String {
        return cards.spacedDescriptions
    }
    
    var lastDealtHandReadableDate: String? {
        guard let date = historyOfDealtCards.last?.date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        return formatter.string(from: date)
    }
    
    var lastDealtHandDate: Date? {
        return historyOfDealtCards.last?.date
    }
    
}
