//
//  TPHDealer.swift
//  TexasPokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//

import Foundation
import Algorithms

public class TPHDealer {

    var evaluator: TPHEvaluator

    var currentDeck: TPHModelDeck

    public var table: TPHTable

    var verbose = false

    public init?() {
        currentDeck = TPHModelDeck()
        table = TPHTable()
        if let ev = TPHEvaluator() {
            evaluator = ev
        } else {
            return nil
        }
    }
    
    public init?(deck: TPHModelDeck) {
        currentDeck = deck
        table = TPHTable()
        if let ev = TPHEvaluator() {
            evaluator = ev
        } else {
            return nil
        }
    }
    
    public init(evaluator: TPHEvaluator) {
        currentDeck = TPHModelDeck()
        table = TPHTable()
        self.evaluator = evaluator
    }
    
    public init(deck: TPHModelDeck, evaluator: TPHEvaluator) {
        currentDeck = deck
        table = TPHTable()
        self.evaluator = evaluator
    }

    var currentGame: String { return table.currentGame }

    var flop: String { return table.flop }

    var turn: String { return table.turn }

    var river: String { return table.river }

    public var currentHandWinner: TPHPlayer? {
        didSet {
            if let ch = currentHandWinner {
                if scores[ch.id] == nil {
                    scores[ch.id] = 1
                } else {
                    scores[ch.id]! += 1
                }
            } else {
                scores = [:]
            }
        }
    }

    var scores = [UUID: Int]()

    func changeDeck() {
        currentDeck = TPHModelDeck()
    }

    func shuffleDeck() {
        currentDeck.shuffle()
    }
    
    func removeCards(from player: TPHPlayer) {
        player.cards = []
    }

    func deal(number: Int) -> [TPHCard] {
        return currentDeck.takeCards(number: number)
    }

    func dealHand() -> [TPHCard] {
        return deal(number: 2)
    }

    public func dealHand(to player: TPHPlayer) {
        player.cards = dealHand()
    }
    
    func deal(cards: [String]) -> [TPHCard] {
        let upCardChars = cards.map({$0.uppercased().map({String($0)})})
        var cardsToDeal = [TPHCard]()
        for cardChars in upCardChars {
            let cardObj = TPHCard(suit: cardChars[1], rank: cardChars[0])
            guard let index = currentDeck.cards.firstIndex(of: cardObj) else {
                NSLog("%@", "ERROR: \(cardObj) is not in the deck")
                break
            }
            currentDeck.cards.remove(at: index)
            cardsToDeal.append(cardObj)
        }
        return cardsToDeal
    }
    
    func deal(cards: [String], to player: TPHPlayer) {
        player.cards = deal(cards: cards)
    }
    
    func deal(cards: [TPHCard], to player: TPHPlayer) {
        var cardsToDeal = [TPHCard]()
        for card in cards {
            guard let indexToRemove = currentDeck.cards.firstIndex(of: card) else {
                NSLog("%@", "ERROR: \(card) is not in the deck")
                break
            }
            currentDeck.cards.remove(at: indexToRemove)
            cardsToDeal.append(card)
        }
        player.cards = cardsToDeal
    }

    public func dealFlop() -> [TPHCard] {
        table.dealtCards = []
        table.burnt = []
        let dealt = dealWithBurning(number: 3)
        table.add(cards: dealt)
        return dealt
    }

    public func dealTurn() -> [TPHCard] {
        let dealt = dealWithBurning(number: 1)
        table.add(cards: dealt)
        return dealt
    }

    public func dealRiver() -> [TPHCard] {
        return dealTurn()
    }

    func burn() -> TPHCard? {
        return currentDeck.takeCards(number: 1).first
    }

    func dealWithBurning(number: Int) -> [TPHCard] {
        guard let burned = burn() else {
            return []
        }
        table.addToBurnt(card: burned)
        return deal(number: number)
    }

    public func evaluateHandAtRiver(for player: TPHPlayer) {
        player.hand = evaluateHandAtRiver(player: player)
    }

    func evaluateHandAtRiver(player: TPHPlayer) -> TPHHand {
        let sevenCards = table.dealtCards + player.cards
        let cardsReps = sevenCards.map({ $0.description })
        // all 5 cards combinations from the 7 cards
        let perms = cardsReps.permutations(ofCount: 5)
        let sortedPerms = perms.map({ $0.sorted(by: <) })
        var handsResult = [TPHHand]()
        for hand in Set(sortedPerms) {
            let h = evaluator.evaluate(cards: hand)
            handsResult.append(TPHHand(rank: h, cards: hand))
        }
        handsResult.sort(by: { $0.rank < $1.rank })
        return handsResult.first!
    }

    public func updateHeadsUpWinner(player1: TPHPlayer, player2: TPHPlayer) {
        currentHandWinner = findHeadsUpWinner(player1: player1, player2: player2)
    }

    func findHeadsUpWinner(player1: TPHPlayer, player2: TPHPlayer) -> TPHPlayer {
        if player1.hand!.rank < player2.hand!.rank {
            return player1 }
        else if player1.hand!.rank == player2.hand!.rank {
            return TPHPlayer(name: "SPLIT") }
        else {
            return player2
        }
    }
    
}
