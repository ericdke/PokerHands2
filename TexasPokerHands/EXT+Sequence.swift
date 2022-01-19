//
//  EXT+Sequence.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation

extension Sequence where Iterator.Element == TPHCard {
    
    var descriptions: [String] {
        return self.map { $0.description }
    }
    
    var spacedDescriptions: String {
        return self.descriptions.joined(separator: " ")
    }
    
    func joinNames(with string: String) -> String {
        return self.map({ $0.name }).joined(separator: string)
    }
    
}
