//
//  TPHPlayer.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHPlayer {

    public init(name: String? = nil) {
        self.name = name ?? ""
    }
    
    var name: String?

    var historyOfDealtCards = [(TPHCard, TPHCard, Date)]()
    
    var frequentHands = [String:Int]()

    var hand: (TPHHandRank, [String])?
    
    var handDescription: String? {
        return hand?.1.joined(separator: " ")
    }
    
    var handNameDescription: String? {
        return hand?.0.name.rawValue.lowercased()
    }

    var cardsHistory: String {
        let mapped = historyOfDealtCards.map { $0.0.description + " " + $0.1.description }
        return mapped.joined(separator: ", ")
    }

    var cards = [TPHCard]() {
        didSet {
            let tu = (cards[0], cards[1], Date())
            historyOfDealtCards.append(tu)
            let fqname = "\(tu.0.description),\(tu.1.description)"
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
        guard let date = historyOfDealtCards.last?.2 else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        return formatter.string(from: date)
    }
    
    var lastDealtHandDate: Date? {
        return historyOfDealtCards.last?.2
    }
    
}
