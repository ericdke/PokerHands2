//
//  TPHEvaluator.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHEvaluator {
    
    let byteRanks: TPHByteRanks
    let deck = TPHCardsDeck()
    
    init?() {
        if let br = TPHByteRanks() {
            byteRanks = br
        } else {
            return nil
        }
    }
    
    func evaluate(cards: [String]) -> TPHHandRank {
        let cardValues = cards.map { self.deck.as_binary($0) }

        let handIndex = cardValues.reduce(0,|) >> 16

        let isFlush = (cardValues.reduce(0xF000,&)) != 0

        if isFlush {
            let flushRank = byteRanks.flushes[handIndex]
            return TPHHandRank(rank: flushRank)
        }

        let unique5Candidate = byteRanks.uniqueToRanks[handIndex]

        if unique5Candidate != 0 {
            return TPHHandRank(rank: unique5Candidate)
        }

        let primeProduct = cardValues.map { $0 & 0xFF }.reduce(1, *)

        let combination = byteRanks.primeProductToCombination.firstIndex(of: primeProduct)!
        return TPHHandRank(rank: byteRanks.combinationToRank[combination])
    }
}
