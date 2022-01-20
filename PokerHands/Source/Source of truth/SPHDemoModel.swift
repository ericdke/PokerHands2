//
//  SPHDemoModel.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import TexasPokerHands

// A simple demo. You don't have to use TPH like this - use and modify as you see fit.

final class SPHDemoModel: ObservableObject {
    
    @Published var results: [TPHHeadsUpResult] = []
    
    @Published var player1Name: String = ""
    @Published var player2Name: String = ""
    
    @Published var numberOfRounds: Int = 10
    @Published var numberOfRoundsLabel: String = "" {
        didSet {
            if let n = Int(numberOfRoundsLabel) {
                if n < 1 {
                    gameIsEnabled = false
                } else {
                    gameIsEnabled = true
                    numberOfRounds = n
                }
            } else {
                gameIsEnabled = false
            }
        }
    }

    @Published var player1Score: Int = 0
    @Published var player2Score: Int = 0

    @Published var gameIsEnabled = true

    private func playOneHandAllIn(player1 p1: TPHPlayer, player2 p2: TPHPlayer, dealer: TPHDealer, completion: @escaping (TPHHeadsUpResult)->()) {
        dealer.dealHand(to: p1)
        dealer.dealHand(to: p2)
        _ = dealer.dealFlop()
        _ = dealer.dealTurn()
        _ = dealer.dealRiver()
        dealer.evaluateHandAtRiver(for: p1)
        dealer.evaluateHandAtRiver(for: p2)
        dealer.updateHeadsUpWinner(player1: p1, player2: p2)
        completion(TPHHeadsUpResult(player1: p1, player2: p2, dealer: dealer))
    }
    
    func playHandsAllIn(player1 p1: TPHPlayer, player2 p2: TPHPlayer) {
        results = []
        player1Score = 0
        player2Score = 0
        let ev = TPHEvaluator()!
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.concurrentPerform(iterations: self.numberOfRounds, execute: { (index) -> Void in
                // We recreate objects to avoid thread issues. You don't need to do that if your game executes entirely on the main thread.
                let dd = TPHDealer(evaluator: ev)
                let pp1 = TPHPlayer(name: p1.name)
                let pp2 = TPHPlayer(name: p2.name)
                self.playOneHandAllIn(player1: pp1, player2: pp2, dealer: dd) { res in
                    DispatchQueue.main.async {
                        self.results.append(res)
                        p1.historyOfDealtCards.append(contentsOf: pp1.historyOfDealtCards)
                        p2.historyOfDealtCards.append(contentsOf: pp2.historyOfDealtCards)
                        switch res.winners {
                        case (true, false):
                            self.player1Score += 1
                        case (false, true):
                            self.player2Score += 1
                        default:
                            break
                        }
                    }
                }
            })
        }
    }
    
}
