//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 18.07.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static let themes: [Theme] = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "💀", "😱", "🧟", "🦇", "🪦", "🩸", "🔮", "🕯", "🧛"], numberOfPairsOfCards: 5, foregroundColor: .orange),
        Theme(name: "Animals", emojis: ["🐼", "🐔", "🦄", "🐶", "🐱", "🐭", "🐽", "🐍", "🐒"], numberOfPairsOfCards: nil, foregroundColor: .gray),
        Theme(name: "Sports", emojis: ["🏀", "🏈", "⚾", "🏸", "🥎", "🏐", "🎱", "🥊", "🥋", "⛷", "🏂"], numberOfPairsOfCards: nil, foregroundColor: .blue),
        Theme(name: "Faces", emojis: ["😀", "😢", "😉", "😂", "😊", "🤪", "😍", "🥳", "🤩"], numberOfPairsOfCards: 5, foregroundColor: .yellow),
        Theme(name: "Food", emojis: ["🍏", "🍆", "🍒", "🍇", "🍓", "🫐", "🌽", "🥩", "🍝", "🍔"], numberOfPairsOfCards: nil, foregroundColor: .green),
        Theme(name: "Transport", emojis: ["🚗", "✈️", "🚲", "⛵️", "🚌", "🚁", "🚀", "🛸", "🚇"], numberOfPairsOfCards: 10, foregroundColor: .red),
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairsOfCards = min(emojis.count, theme.numberOfPairsOfCards ?? Int.random(in: 2...theme.emojis.count))
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    static func chooseAnotherTheme() -> Theme {
        themes.randomElement()!
    }
    
    @Published private var model: MemoryGame<String>
    
    var cards: [MemoryGame<String>.Card] { model.cards }
    private(set) var theme: Theme
    
    init() {
            let theme = Self.chooseAnotherTheme()
            model = Self.createMemoryGame(theme: theme)
            self.theme = theme
        }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = Self.chooseAnotherTheme()
        model = Self.createMemoryGame(theme: theme)
    }
    
    struct Theme {
        let name: String
        let emojis: [String]
        let numberOfPairsOfCards: Int?
        let foregroundColor: Color
    }
}
