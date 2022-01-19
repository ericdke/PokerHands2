//
//  TPHCardsDeck.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

class TPHCardsDeck {
    
    var cards: [String:Int]
    
    var count: Int { return cards.count }
    
    init() {
        cards = [:]

        for face in TPHConstants.faces.keys {
            for suit in TPHConstants.suitDetails.keys {
                let faceIndex = TPHConstants.faces[face]!["index"]!
                let faceValue = faceIndex << 8
                let suitValue = TPHConstants.suitDetails[suit]! << 12
                let facePrime = TPHConstants.faces[face]!["prime"]!
                let rank = 1 << (faceIndex + 16)
                cards[face+suit] = rank | suitValue | faceValue | facePrime
            }
        }
    }

    func as_binary(_ card:String) -> Int {
        return cards[card]!
    }
}
