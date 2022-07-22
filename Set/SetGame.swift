//
//  SetGame.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import Foundation

struct SetGame {
    private(set) var deck: [Card] = {
        var cards = [Card]()
        Card.Number.allCases.forEach { number in
            Card.Shape.allCases.forEach { shape in
                Card.Shading.allCases.forEach { shading in
                    Card.Color.allCases.forEach { color in
                        cards.append(Card(number: number, shape: shape, shading: shading, color: color))
                    }
                }
            }
        }
        return cards.shuffled()
    }()
    private(set) var cards: [Card] = []
    private(set) var score = 0
    
    init() {
        layFirstCards()
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        cards[chosenIndex].isChosen.toggle()
        
        let chosenCards = cards.filter(\.isChosen)
        if chosenCards.count == 3 {
            if chosenCards.isAllSameOrAllDifferent(\.number),
               chosenCards.isAllSameOrAllDifferent(\.shape),
               chosenCards.isAllSameOrAllDifferent(\.shading),
               chosenCards.isAllSameOrAllDifferent(\.color)
            {
                cards = cards.filter { chosenCards.contains($0) }
            } else {
                cards.indices.forEach { cards[$0].isChosen = false }
            }
        }
    }
    
    mutating func layMoreCards() {
        let moreCards = deck.suffix(3)
        cards.append(contentsOf: moreCards)
        deck = deck.dropLast(3)
    }
    
    mutating func layFirstCards() {
        for _ in 0..<4 { layMoreCards() }
    }
    
    private mutating func incrementScore() {
        
    }
    
    private mutating func decrementScore() {

    }
    
    struct Card: Hashable, Identifiable, Equatable {
        enum Number: CaseIterable { case one, two, three }
        enum Shape: CaseIterable { case diamond, squiggle, oval }
        enum Shading: CaseIterable { case solid, striped, open }
        enum Color: CaseIterable { case red, green, purple }

        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var isChosen = false
                
        // Identifiable conformance
        let id = UUID()
    }
}

extension Array where Element: Hashable {
    func isAllSame<T: Equatable>(_ by: KeyPath<Element, T>) -> Bool {
        return dropFirst().allSatisfy({ $0[keyPath: by] == first?[keyPath: by] })
    }
    
    func isAllDifferent<T: Equatable>(_ by: KeyPath<Element, T>) -> Bool {
        return Set(self).count == count
    }
    
    func isAllSameOrAllDifferent<T: Equatable>(_ by: KeyPath<Element, T>) -> Bool {
        return isAllSame(by) || isAllDifferent(by)
    }
}
