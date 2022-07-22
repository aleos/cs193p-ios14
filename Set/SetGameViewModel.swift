//
//  SetGameViewModel.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    
    private var game = SetGame()
    
    var cards: [Card] { game.cards }
    var score: Int { game.score }
    
    var themeForegroundColor: Color { .white }

    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func newGame() {
        game = SetGame()
    }
}
