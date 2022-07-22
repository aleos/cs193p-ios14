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
        VStack {
            HStack(alignment: .firstTextBaseline) {
//                Text(game.themeName).font(.largeTitle)
                Text("Score: \(game.score)")
            }
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            .foregroundColor(game.themeForegroundColor)
            Spacer()
            Button {
                game.newGame()
            } label: {
                Text("New Game").font(.largeTitle)
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: SetGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
//                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                Face().foregroundColor(.red)
//                } else if card.isMatched {
//                    shape.opacity(0)
//                } else {
//                    shape.fill()
//                }
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
    }
}
