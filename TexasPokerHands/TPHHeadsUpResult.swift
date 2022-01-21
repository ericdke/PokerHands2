//
//  TPHHeadsUpResult.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 20/01/2022.
//

import Foundation

public struct TPHHeadsUpResult: Identifiable {

    public let id = UUID()
    public let player1: TPHPlayer
    public let player2: TPHPlayer
    
    // Two players win in case of split pot
    public let winnerIds: [UUID]
    
    // Convenience parsing - might want to refactor as methods or lazy vars instead
    public let winnerName: String
    public let winnerHoleCards: String
    public let winnerHandName: String
    public let winnerHandDescription: String
    public let opponentName: String
    public let opponentHoleCards: String
    public let opponentHandName: String
    public let opponentHandDescription: String
    public let winners: (p1: Bool, p2: Bool)
    public let winnerHoleCardsFileNames: [String]
    public let opponentHoleCardsFileNames: [String]
    public let tableCards: String
    public let tableCardsFileNames: [String]
    
    public init(player1 p1: TPHPlayer, player2 p2: TPHPlayer, dealer: TPHDealer) {
        player1 = p1
        player2 = p2
        
        winnerIds = dealer.currentHandWinner.compactMap { $0.id }
        
        if dealer.currentHandWinner.isEmpty {
            winnerName = "[no winner]"
        } else if dealer.currentHandWinner.count > 1 {
            winnerName = "\(p1.name) and \(p2.name)"
        } else {
            winnerName = dealer.currentHandWinner[0].name
        }
        
        if dealer.currentHandWinner.isEmpty {
            winnerHoleCards = "[empty]"
        } else if dealer.currentHandWinner.count > 1 {
            winnerHoleCards = "\(p1.name): \(p1.holeCards) \(p2.name): \(p2.holeCards)"
        } else {
            winnerHoleCards = dealer.currentHandWinner[0].holeCards
        }
        
        if dealer.currentHandWinner.isEmpty {
            winnerHandName = "[not available]"
            winnerHandDescription = "[empty]"
        } else if dealer.currentHandWinner.count > 1 {
            if let p1h = p1.handDescription
            {
                if let p1n = p1.handNameDescription
                {
                    winnerHandName = p1n
                    winnerHandDescription = p1h
                } else {
                    winnerHandName = "[not available]"
                    winnerHandDescription = p1h
                }
            } else {
                winnerHandName = "[not available]"
                winnerHandDescription = "[not available]"
            }
        } else {
            if let wh = dealer.currentHandWinner[0].handDescription {
                if let wn = dealer.currentHandWinner[0].handNameDescription {
                    winnerHandName = wn
                    winnerHandDescription = wh
                } else {
                    winnerHandName = "[not available]"
                    winnerHandDescription = wh
                }
            } else {
                winnerHandName = "[not available]"
                winnerHandDescription = "[not available]"
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            opponentName = "[no opponent]"
        } else if dealer.currentHandWinner.count > 1 {
            opponentName = "\(p1.name) and \(p2.name)"
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                opponentName = p2.name
            } else {
                opponentName = p1.name
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            opponentHoleCards = "[no opponent]"
        } else if dealer.currentHandWinner.count > 1 {
            opponentHoleCards = "\(p1.name): \(p1.holeCards) \(p2.name): \(p2.holeCards)"
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                opponentHoleCards = p2.holeCards
            } else {
                opponentHoleCards = p1.holeCards
            }
        }
        
        if dealer.currentHandWinner.isEmpty {
            opponentHandName = "[not available]"
            opponentHandDescription = "[no opponent]"
        } else if dealer.currentHandWinner.count > 1 {
            if let p2h = p2.handDescription
            {
                if let p2n = p2.handNameDescription
                {
                    opponentHandName = p2n
                    opponentHandDescription = p2h
                } else {
                    opponentHandName = "[not available]"
                    opponentHandDescription = p2h
                }
            } else {
                opponentHandName = "[not available]"
                opponentHandDescription = "[not available]"
            }
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                if let ph = p2.handDescription {
                    if let p2n = p2.handNameDescription {
                        opponentHandName = p2n
                        opponentHandDescription = ph
                    } else {
                        opponentHandName = "[not available]"
                        opponentHandDescription = ph
                    }
                } else {
                    opponentHandName = "[not available]"
                    opponentHandDescription = "[not available]"
                }
            } else {
                if let ph = p1.handDescription {
                    if let p1n = p1.handNameDescription {
                        opponentHandName = p1n
                        opponentHandDescription = ph
                    } else {
                        opponentHandName = "[not available]"
                        opponentHandDescription = ph
                    }
                } else {
                    opponentHandName = "[not available]"
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
        
        if dealer.currentHandWinner.isEmpty {
            winnerHoleCardsFileNames = []
            opponentHoleCardsFileNames = []
        } else if dealer.currentHandWinner.count > 1 {
            winnerHoleCardsFileNames = p1.cards.map { $0.fileName }
            opponentHoleCardsFileNames = p2.cards.map { $0.fileName }
        } else if dealer.currentHandWinner[0].id == p1.id {
            winnerHoleCardsFileNames = p1.cards.map { $0.fileName }
            opponentHoleCardsFileNames = p2.cards.map { $0.fileName }
        } else {
            winnerHoleCardsFileNames = p2.cards.map { $0.fileName }
            opponentHoleCardsFileNames = p1.cards.map { $0.fileName }
        }
        
        tableCards = dealer.table.currentGame
        tableCardsFileNames = dealer.table.dealtCards.map { $0.fileName }
    }
}
