//
//  SetGameViewModel.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import SwiftUI

final class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var game = SetGame()
    
    var cards: [Card] { game.cards }
    var score: Int { game.score }
    
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func layCards() {
        game.layCards()
    }
    
    func newGame() {
        game = SetGame()
    }
}
