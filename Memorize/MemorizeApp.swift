//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 14.07.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
