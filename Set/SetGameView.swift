//
//  SetGameView.swift
//  Set
//
//  Created by Alexander Ostrovsky on 21.07.2022.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    CardView(card: card, currentSetSelection: game.currentSetSelection)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
                Spacer()
                Button {
                    game.dealMoreCards()
                } label: {
                    Text("Deal 3 More Cards")
                    .font(.title)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Score: \(game.score)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    game.newGame()
                } label: {
                    Text("New Game")
                }
            }
        }
    }
}

struct CardView: View {
    let card: SetGameViewModel.Card
    let currentSetSelection: SetGame.SetSelection
    
    private var borderColor: Color {
        if card.isSelected {
            switch currentSetSelection {
            case .matching: return .green
            case .nonmatching: return .red
            case .incomplete: return .accentColor
            }
        } else {
            return .secondary
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(borderColor)
                Face(number: card.number, shape: card.shape, shading: card.shading, color: card.color)
                    .padding(4)
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius = 10.0
        static let lineWidth = 3.0
        static let fontScale = 0.7
        static let circleOpacity = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(game: SetGameViewModel())
            .preferredColorScheme(.dark)
        SetGameView(game: SetGameViewModel())
            .preferredColorScheme(.light)
    }
}
