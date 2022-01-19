//
//  SPHDemoModel.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import TexasPokerHands

final class SPHDemoModel: ObservableObject {
    
    let dealer = TPHDealer()!
    
    func playOneHandAllIn() {
        let p1 = TPHPlayer(name: "Jesus")
        let p2 = TPHPlayer(name: "Paul")
        
        dealer.dealHand(to: p1)
        dealer.dealHand(to: p2)
        
        _ = dealer.dealFlop()
        _ = dealer.dealTurn()
        _ = dealer.dealRiver()
        
        dealer.evaluateHandAtRiver(for: p1)
        dealer.evaluateHandAtRiver(for: p2)
        
        dealer.updateHeadsUpWinner(player1: p1, player2: p2)
        

        print(dealer.table.currentGame)
        dump(dealer.currentHandWinner)
    }
    
}
