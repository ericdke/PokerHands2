//
//  TPHHandRank.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

public class TPHHandRank: Equatable {
    
    public let rank: Int
    public let name: TPHConstants.RankName
    
    public init(rank:Int) {
        self.rank = rank
        let start = Array(TPHConstants.rankStarts.keys.filter {$0 >= rank}).sorted { $0 < $1 }.first!
        self.name = TPHConstants.rankStarts[start]!
    }
    
}

public func == (lhs: TPHHandRank, rhs: TPHHandRank) -> Bool {
    return lhs.rank == rhs.rank
}

public func < (lhs: TPHHandRank, rhs: TPHHandRank) -> Bool {
    return lhs.rank < rhs.rank
}
