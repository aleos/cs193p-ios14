//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 14.07.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(game.themeName).font(.largeTitle)
                Text("Score: \(game.score)")
            }
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                    
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
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20)).padding(5).opacity(DrawingConstants.circleOpacity)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius = 10.0
        static let lineWidth = 3.0
        static let fontScale = 0.7
        static let circleOpacity = 0.5
    }
}

// MARK: Previews

struct ContentView_Previews: PreviewProvider {
    static var game: EmojiMemoryGame = {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return game
    }()
    
    static var previews: some View {
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
