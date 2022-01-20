//
//  TPHHeadsUpResult.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 20/01/2022.
//

import Foundation

public struct TPHHeadsUpResult {

    public let winnerName: String
    public let winnerHoleCards: String
    public let winnerHandDescription: String
    public let opponentName: String
    public let opponentHoleCards: String
    public let opponentHandDescription: String
    public let winners: (p1: Bool, p2: Bool)
    
    public init(player1 p1: TPHPlayer, player2 p2: TPHPlayer, dealer: TPHDealer) {
        if dealer.currentHandWinner.isEmpty {
            winnerName = "[no winner]"
        } else if dealer.currentHandWinner.count > 1 {
            winnerName = "[split]"
        } else {
            winnerName = dealer.currentHandWinner[0].nameSafe
        }
        
        if dealer.currentHandWinner.isEmpty {
            winnerHoleCards = "[empty]"
        } else if dealer.currentHandWinner.count > 1 {
            winnerHoleCards = "\(p1.nameSafe): \(p1.holeCards) \(p2.nameSafe): \(p2.holeCards)"
        } else {
            winnerHoleCards = dealer.currentHandWinner[0].holeCards
        }
        
        if dealer.currentHandWinner.isEmpty {
            winnerHandDescription = "[empty]"
        } else if dealer.currentHandWinner.count > 1 {
            if let p1h = p1.handDescription,
                let p2h = p2.handDescription
            {
                if let p1n = p1.handNameDescription,
                    let p2n = p2.handNameDescription
                {
                    winnerHandDescription = "\(p1.nameSafe): \(p1h) \(p1n) \(p2.nameSafe): \(p2h) \(p2n)"
                } else {
                    winnerHandDescription = "\(p1.nameSafe): \(p1h) \(p2.nameSafe): \(p2h)"
                }
            } else {
                winnerHandDescription = "[not available]"
            }
        } else {
            if let wh = dealer.currentHandWinner[0].handDescription {
                if let wn = dealer.currentHandWinner[0].handNameDescription {
                    winnerHandDescription = "\(wh) \(wn)"
                } else {
                    winnerHandDescription = wh
                }
            } else {
                winnerHandDescription = "[not available]"
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            opponentName = "[no opponent]"
        } else if dealer.currentHandWinner.count > 1 {
            opponentName = "[split]"
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                opponentName = p2.nameSafe
            } else {
                opponentName = p1.nameSafe
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            opponentHoleCards = "[no opponent]"
        } else if dealer.currentHandWinner.count > 1 {
            opponentHoleCards = "\(p1.nameSafe): \(p1.holeCards) \(p2.nameSafe): \(p2.holeCards)"
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                opponentHoleCards = p2.holeCards
            } else {
                opponentHoleCards = p1.holeCards
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            opponentHandDescription = "[no opponent]"
        } else if dealer.currentHandWinner.count > 1 {
            if let p1h = p1.handDescription,
                let p2h = p2.handDescription
            {
                if let p1n = p1.handNameDescription,
                    let p2n = p2.handNameDescription
                {
                    opponentHandDescription = "\(p1.nameSafe): \(p1h) \(p1n) \(p2.nameSafe): \(p2h) \(p2n)"
                } else {
                    opponentHandDescription = "\(p1.nameSafe): \(p1h) \(p2.nameSafe): \(p2h)"
                }
            } else {
                opponentHandDescription = "[not available]"
            }
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                if let ph = p2.handDescription {
                    if let p2n = p2.handNameDescription {
                        opponentHandDescription = "\(ph) \(p2n)"
                    } else {
                        opponentHandDescription = ph
                    }
                } else {
                    opponentHandDescription = "[not available]"
                }
            } else {
                if let ph = p1.handDescription {
                    if let p1n = p1.handNameDescription {
                        opponentHandDescription = "\(ph) \(p1n)"
                    } else {
                        opponentHandDescription = ph
                    }
                } else {
                    opponentHandDescription = "[not available]"
                }
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            winners = (p1: false, p2: false)
        } else if dealer.currentHandWinner.count > 1 {
            winners = (p1: true, p2: true)
        } else if dealer.currentHandWinner[0].id == p1.id {
            winners = (p1: true, p2: false)
        } else {
            winners = (p1: false, p2: true)
        }
    }
}
