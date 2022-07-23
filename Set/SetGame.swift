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
        layCards()
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        cards[chosenIndex].isSelected.toggle()
        
        let selectedCards = cards.filter(\.isSelected)
        if selectedCards.count == 3 {
            if selectedCards.isAllSameOrAllDifferent(\.number),
               selectedCards.isAllSameOrAllDifferent(\.shape),
               selectedCards.isAllSameOrAllDifferent(\.shading),
               selectedCards.isAllSameOrAllDifferent(\.color)
            {
                cards = cards.filter { !selectedCards.contains($0) }
                if cards.count < 12 {
                    layCards()
                }
            }
            cards.indices.forEach { cards[$0].isSelected = false }
        }
    }
    
    mutating func layCards() {
        guard !deck.isEmpty else { return }
        repeat {
            let moreCards = deck.suffix(3)
            cards.append(contentsOf: moreCards)
            deck = deck.dropLast(3)
        } while cards.count < 12
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
        
        var isSelected = false
                
        // Identifiable conformance
        let id = UUID()
    }
}

extension Array where Element: Hashable {
    func isAllSame<T: Equatable>(_ by: KeyPath<Element, T>) -> Bool {
        return dropFirst().allSatisfy({ $0[keyPath: by] == first?[keyPath: by] })
    }
    
    func isAllDifferent<T: Hashable>(_ by: KeyPath<Element, T>) -> Bool {
        return Set(map({ $0[keyPath: by] })).count == count
    }
    
    func isAllSameOrAllDifferent<T: Hashable>(_ by: KeyPath<Element, T>) -> Bool {
        return isAllSame(by) || isAllDifferent(by)
    }
}
