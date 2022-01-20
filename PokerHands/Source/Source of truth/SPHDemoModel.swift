//
//  SPHDemoModel.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import TexasPokerHands

final class SPHDemoModel: ObservableObject {
    
    let dealer = TPHDealer()!
    
    @Published var player1Name: String = ""
    
    @Published var player2Name: String = ""
    
    @Published var numberOfRoundsLabel: String = "" {
        didSet {
            numberOfRounds = Int(numberOfRoundsLabel) ?? 100
        }
    }
    
    @Published var numberOfRounds: Int = 100
    
    @Published var player1Score: Int = 0
    
    @Published var player2Score: Int = 0
    
    var p1name: String {
        player1Name.isEmpty ? "Annette" : player1Name
    }
    
    var p2name: String {
        player2Name.isEmpty ? "Johnny" : player2Name
    }
    
    @Published var results: [TPHHeadsUpResult] = []
    
    
    private func playOneHandAllIn(player1 p1: TPHPlayer, player2 p2: TPHPlayer) -> TPHHeadsUpResult {
        dealer.dealHand(to: p1)
        dealer.dealHand(to: p2)
        _ = dealer.dealFlop()
        _ = dealer.dealTurn()
        _ = dealer.dealRiver()
        dealer.evaluateHandAtRiver(for: p1)
        dealer.evaluateHandAtRiver(for: p2)
        dealer.updateHeadsUpWinner(player1: p1, player2: p2)
        return TPHHeadsUpResult(player1: p1, player2: p2, dealer: dealer)
    }
    
    func playHandsAllIn(player1 p1: TPHPlayer, player2 p2: TPHPlayer, number n: Int? = nil) {
        results = []
        let number = n ?? numberOfRounds
        if dealer.currentDeck.count != dealer.currentDeck.capacity {
            dealer.reset()
        }
        for _ in 1...number {
            let res = playOneHandAllIn(player1: p1, player2: p2)
            results.append(res)
            switch res.winners {
            case (true, false):
                player1Score += 1
            case (false, true):
                player2Score += 1
            case (true, true):
                player1Score += 1
                player2Score += 1
            case (false, false):
                break
            }
            dealer.reset()
        }
    }
    
}
