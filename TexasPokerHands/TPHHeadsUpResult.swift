//
//  TPHHeadsUpResult.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 20/01/2022.
//

import Foundation

public struct TPHHeadsUpResult {
    
    public let p1: TPHPlayer
    public let p2: TPHPlayer
    public let dealer: TPHDealer
    
    public init(player1: TPHPlayer, player2: TPHPlayer, dealer: TPHDealer) {
        p1 = player1
        p2 = player2
        self.dealer = dealer
    }
    
    public var winnerName: String {
        if dealer.currentHandWinner.isEmpty {
            return "[no winner]"
        }
        if dealer.currentHandWinner.count > 1 {
            return "[split]"
        } else {
            return dealer.currentHandWinner[0].nameSafe
        }
    }
    
    public var winnerHoleCards: String {
        if dealer.currentHandWinner.isEmpty {
            return "[empty]"
        }
        if dealer.currentHandWinner.count > 1 {
            return "\(p1.nameSafe): \(p1.holeCards) \(p2.nameSafe): \(p2.holeCards)"
        } else {
            return dealer.currentHandWinner[0].holeCards
        }
    }
    
    public var winnerHandDescription: String {
        if dealer.currentHandWinner.isEmpty {
            return "[empty]"
        }
        if dealer.currentHandWinner.count > 1 {
            if let p1h = p1.handDescription,
                let p2h = p2.handDescription
            {
                if let p1n = p1.handNameDescription,
                    let p2n = p2.handNameDescription
                {
                    return "\(p1.nameSafe): \(p1h) \(p1n) \(p2.nameSafe): \(p2h) \(p2n)"
                } else {
                    return "\(p1.nameSafe): \(p1h) \(p2.nameSafe): \(p2h)"
                }
            } else {
                return "[not available]"
            }
        } else {
            if let wh = dealer.currentHandWinner[0].handDescription {
                if let wn = dealer.currentHandWinner[0].handNameDescription {
                    return "\(wh) \(wn)"
                } else {
                    return wh
                }
            } else {
                return "[not available]"
            }
        }
    }
    
    public var opponentName: String {
        if dealer.currentHandWinner.isEmpty {
            return "[no opponent]"
        }
        if dealer.currentHandWinner.count > 1 {
            return "[split]"
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                return p2.nameSafe
            } else {
                return p1.nameSafe
            }
        }
    }
    
    public var opponentHoleCards: String {
        if dealer.currentHandWinner.isEmpty {
            return "[no opponent]"
        }
        if dealer.currentHandWinner.count > 1 {
            return "\(p1.nameSafe): \(p1.holeCards) \(p2.nameSafe): \(p2.holeCards)"
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                return p2.holeCards
            } else {
                return p1.holeCards
            }
        }
    }
    
    public var opponentHandDescription: String {
        if dealer.currentHandWinner.isEmpty {
            return "[no opponent]"
        }
        if dealer.currentHandWinner.count > 1 {
            if let p1h = p1.handDescription,
                let p2h = p2.handDescription
            {
                if let p1n = p1.handNameDescription,
                    let p2n = p2.handNameDescription
                {
                    return "\(p1.nameSafe): \(p1h) \(p1n) \(p2.nameSafe): \(p2h) \(p2n)"
                } else {
                    return "\(p1.nameSafe): \(p1h) \(p2.nameSafe): \(p2h)"
                }
            } else {
                return "[not available]"
            }
        } else {
            if dealer.currentHandWinner[0].id == p1.id {
                if let ph = p2.handDescription {
                    if let p2n = p2.handNameDescription {
                        return "\(ph) \(p2n)"
                    } else {
                        return ph
                    }
                } else {
                    return "[not available]"
                }
            } else {
                if let ph = p1.handDescription {
                    if let p1n = p1.handNameDescription {
                        return "\(ph) \(p1n)"
                    } else {
                        return ph
                    }
                } else {
                    return "[not available]"
                }
            }
        }
    }
    
    public var winners: (p1: Bool, p2: Bool) {
        if dealer.currentHandWinner.isEmpty {
            return (p1: false, p2: false)
        }
        if dealer.currentHandWinner.count > 1 {
            return (p1: true, p2: true)
        }
        if dealer.currentHandWinner[0].id == p1.id {
            return (p1: true, p2: false)
        } else {
            return (p1: false, p2: true)
        }
    }
    
}
