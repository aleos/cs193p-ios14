//
//  SetApp.swift
//  Set
//
//  Created by Alexander Ostrovsky on 21.07.2022.
//

import SwiftUI

@main
struct SetApp: App {
    let game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
