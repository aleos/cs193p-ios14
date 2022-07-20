//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 18.07.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
    private var timeOfLastPairChoice: Date?
    private var scoreTimeMultiplier: Int {
        guard let timeOfLastPairChoice = timeOfLastPairChoice else { return 1 } // without a multiplier at the beginning
        let timeInterval = Date().timeIntervalSince(timeOfLastPairChoice)
        return max(10 - Int(timeInterval.rounded()), 1)
    }

    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    incrementScore()
                } else {
                    if cards[chosenIndex].isSeen {
                        decrementScore()
                    }
                    if cards[potentialMatchIndex].isSeen {
                        decrementScore()
                    }
                }
                cards[chosenIndex].isSeen = true
                cards[potentialMatchIndex].isSeen = true
                timeOfLastPairChoice = Date()
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    private mutating func incrementScore() {
            score += 2 * scoreTimeMultiplier
            print("Score time multiplier = \(scoreTimeMultiplier)")
        }
        
        private mutating func decrementScore() {
            score -= 1 * scoreTimeMultiplier
            print("Score time multiplier = \(scoreTimeMultiplier)")
        }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? { count == 1 ? first : nil }
}
