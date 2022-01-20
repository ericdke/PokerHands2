//
//  TPHPlayer.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHPlayer {
    
    public let id = UUID()

    public init(name: String? = nil) {
        self.name = name ?? ""
    }
    
    public var name: String?
    
    public var nameSafe: String {
        name ?? "[anonymous]"
    }

    public var historyOfDealtCards = [TPHPocketCard]()
    
    public var frequentHands = [String:Int]()

    public var hand: TPHHand?
    
    public var handDescription: String? {
        return hand?.cards.joined(separator: " ")
    }
    
    public var handNameDescription: String? {
        return hand?.rank.name.rawValue.lowercased()
    }

    public var cardsHistory: String {
        let mapped = historyOfDealtCards.map { "\($0.card1.description) \($0.card2.description)" }
        return mapped.joined(separator: ", ")
    }

    public var cards = [TPHCard]() {
        didSet {
            let pc = TPHPocketCard(card1: cards[0], card2: cards[1], date: Date())
            historyOfDealtCards.append(pc)
            let fqname = "\(pc.card1.description),\(pc.card2.description)"
            if frequentHands[fqname] == nil {
                frequentHands[fqname] = 1
            } else {
                frequentHands[fqname]! += 1
            }
        }
    }

    public var cardsNames: String {
        return cards.joinNames(with: ", ")
    }

    public var count: Int {
        return cards.count
    }

    public var holeCards: String {
        return cards.spacedDescriptions
    }
    
    var lastDealtHandReadableDate: String? {
        guard let date = historyOfDealtCards.last?.date else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        return formatter.string(from: date)
    }
    
    public var lastDealtHandDate: Date? {
        return historyOfDealtCards.last?.date
    }
    
}
