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
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
                Spacer()
                Button {
                    game.layCards()
                } label: {
                    Image(systemName: "goforward.plus")
                    .font(.largeTitle)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Score: \(game.score)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    game.newGame()
                } label: {
                    Image(systemName: "repeat")
                        .font(.title2)
                }

            }
        }
    }
}

struct CardView: View {
    let card: SetGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(.white)
                let color: Color = card.isSelected ? .accentColor : Color.secondary
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(color)
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
