//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 14.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
