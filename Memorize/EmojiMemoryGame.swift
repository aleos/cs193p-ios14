//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 18.07.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairsOfCards = min(emojis.count, theme.numberOfPairsOfCards ?? Int.random(in: 2...theme.emojis.count))
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    @Published private var theme: Theme
    
    var cards: [Card] { model.cards }
    var score: Int { model.score }
    
    var themeName: String { theme.name }
    var themeForegroundColor: Color { Color(from: theme.foregroundColor) ?? .white }
    
    init() {
        let theme = Theme()
        self.theme = theme
        model = Self.createMemoryGame(theme: theme)
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = Theme()
        model = Self.createMemoryGame(theme: theme)
    }
}

private extension Color {
    init?(from name: String) {
        switch name {
        case "orange": self = .orange
        case "gray": self = .gray
        case "blue": self = .blue
        case "yellow": self = .yellow
        case "green": self = .green
        case "red": self = .red
        default: return nil
        }
    }
}
