//
//  TPHHandRank.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

class TPHHandRank: Equatable {
    
    let rank: Int
    let name: TPHConstants.RankName
    
    init(rank:Int) {
        self.rank = rank
        let start = Array(TPHConstants.rankStarts.keys.filter {$0 >= rank}).sorted { $0 < $1 }.first!
        self.name = TPHConstants.rankStarts[start]!
    }
    
}

func == (lhs: TPHHandRank, rhs: TPHHandRank) -> Bool {
    return lhs.rank == rhs.rank
}

func < (lhs: TPHHandRank, rhs: TPHHandRank) -> Bool {
    return lhs.rank < rhs.rank
}
