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
    
    func playOneHandAllIn() -> TPHHeadsUpResult {
        let p1 = TPHPlayer(name: p1name)
        let p2 = TPHPlayer(name: p2name)
        
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
    
}
