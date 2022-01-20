//
//  SPHDemoModel.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import TexasPokerHands

// A simple demo. You don't have to use TPH like this - use and modify as you see fit.

final class SPHDemoModel: ObservableObject {
    
    let dealer = TPHDealer()!

    @Published var results: [TPHHeadsUpResult] = []
    
    @Published var player1Name: String = ""
    @Published var player2Name: String = ""
    
    @Published var numberOfRounds: Int = 10
    @Published var numberOfRoundsLabel: String = "" {
        didSet {
            numberOfRounds = Int(numberOfRoundsLabel) ?? 10
        }
    }

    @Published var player1Score: Int = 0
    @Published var player2Score: Int = 0
    
    var p1name: String {
        player1Name.isEmpty ? "Annette" : player1Name.localizedCapitalized
    }
    
    var p2name: String {
        player2Name.isEmpty ? "Johnny" : player2Name.localizedCapitalized
    }

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
    
    func playHandsAllIn(player1 p1: TPHPlayer, player2 p2: TPHPlayer, number n: Int? = nil) {
        results = []
        player1Score = 0
        player2Score = 0
        let number = n ?? numberOfRounds
        let ev = TPHEvaluator()!
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.concurrentPerform(iterations: number, execute: { (index) -> Void in
                // We recreate objects to avoid thread issues. You don't need to do that if your game executes entirely on the main thread.
                let dd = TPHDealer(evaluator: ev)
                let pp1 = TPHPlayer(name: p1.nameSafe)
                let pp2 = TPHPlayer(name: p2.nameSafe)
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
