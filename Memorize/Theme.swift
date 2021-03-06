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
        Theme(name: "Halloween", emojis: ["ðŧ", "ð", "ð·", "ð", "ðą", "ð§", "ðĶ", "ðŠĶ", "ðĐļ", "ðŪ", "ðŊ", "ð§"], numberOfPairsOfCards: 5, foregroundColor: "orange"),
        Theme(name: "Animals", emojis: ["ðž", "ð", "ðĶ", "ðķ", "ðą", "ð­", "ð―", "ð", "ð"], numberOfPairsOfCards: nil, foregroundColor: "gray"),
        Theme(name: "Sports", emojis: ["ð", "ð", "âū", "ðļ", "ðĨ", "ð", "ðą", "ðĨ", "ðĨ", "â·", "ð"], numberOfPairsOfCards: nil, foregroundColor: "blue"),
        Theme(name: "Faces", emojis: ["ð", "ðĒ", "ð", "ð", "ð", "ðĪŠ", "ð", "ðĨģ", "ðĪĐ"], numberOfPairsOfCards: 5, foregroundColor: "yellow"),
        Theme(name: "Food", emojis: ["ð", "ð", "ð", "ð", "ð", "ðŦ", "ð―", "ðĨĐ", "ð", "ð"], numberOfPairsOfCards: nil, foregroundColor: "green"),
        Theme(name: "Transport", emojis: ["ð", "âïļ", "ðē", "âĩïļ", "ð", "ð", "ð", "ðļ", "ð"], numberOfPairsOfCards: 10, foregroundColor: "red"),
    ]
    
    init() {
        self = Self.themes.randomElement()!
    }
}
