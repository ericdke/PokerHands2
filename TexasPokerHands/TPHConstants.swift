//
//  TPHConstants.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

class TPHConstants {
    
    static let suits = ["♠","♣","♥","♦"]
    
    static let ranks = ["A","K","Q","J","T","9","8","7","6","5","4","3","2"]
    
    enum RankName: String {
        case highCard = "High Card"
        case onePair = "One Pair"
        case twoPairs = "Two Pairs"
        case threeOfAKind = "Three Of A Kind"
        case straight = "A Straight"
        case flush = "A Flush"
        case fullHouse = "A Full House"
        case fourOfAKind = "Four Of A Kind"
        case straightFlush = "A Straight Flush"
    }
    
    static var rankStarts: [Int: RankName] = [
        7462: .highCard,
        6185: .onePair,
        3325: .twoPairs,
        2467: .threeOfAKind,
        1609: .straight,
        1599: .flush,
        322: .fullHouse,
        166: .fourOfAKind,
        10: .straightFlush
    ]

    static let suitDetails: [String: Int] = [
        "♠": 0b0001,
        "♥": 0b0010,
        "♦": 0b0100,
        "♣": 0b1000
    ]

    static let faces: [String:[String:Int]] = [
        "2":["index":0, "prime": 2],
        "3":["index":1, "prime": 3],
        "4":["index":2, "prime": 5],
        "5":["index":3, "prime": 7],
        "6":["index":4, "prime": 11],
        "7":["index":5, "prime": 13],
        "8":["index":6, "prime": 17],
        "9":["index":7, "prime": 19],
        "T":["index":8, "prime": 23],
        "J":["index":9, "prime": 29],
        "Q":["index":10, "prime": 31],
        "K":["index":11, "prime": 37],
        "A":["index":12, "prime": 41]
    ]
    
}
