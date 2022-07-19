//
//  Theme.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 19.07.2022.
//

import Foundation

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairsOfCards: Int?
    let foregroundColor: String
}

extension Theme {
    private static let themes: [Theme] = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "💀", "😱", "🧟", "🦇", "🪦", "🩸", "🔮", "🕯", "🧛"], numberOfPairsOfCards: 5, foregroundColor: "orange"),
        Theme(name: "Animals", emojis: ["🐼", "🐔", "🦄", "🐶", "🐱", "🐭", "🐽", "🐍", "🐒"], numberOfPairsOfCards: nil, foregroundColor: "gray"),
        Theme(name: "Sports", emojis: ["🏀", "🏈", "⚾", "🏸", "🥎", "🏐", "🎱", "🥊", "🥋", "⛷", "🏂"], numberOfPairsOfCards: nil, foregroundColor: "blue"),
        Theme(name: "Faces", emojis: ["😀", "😢", "😉", "😂", "😊", "🤪", "😍", "🥳", "🤩"], numberOfPairsOfCards: 5, foregroundColor: "yellow"),
        Theme(name: "Food", emojis: ["🍏", "🍆", "🍒", "🍇", "🍓", "🫐", "🌽", "🥩", "🍝", "🍔"], numberOfPairsOfCards: nil, foregroundColor: "green"),
        Theme(name: "Transport", emojis: ["🚗", "✈️", "🚲", "⛵️", "🚌", "🚁", "🚀", "🛸", "🚇"], numberOfPairsOfCards: 10, foregroundColor: "red"),
    ]
    
    init() {
        self = Self.themes.randomElement()!
    }
}
