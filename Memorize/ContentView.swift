//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 14.07.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojiCount = 14
    private static let themes: [Theme] = [
            Theme(name: "Faces", icon: "face.smiling", emojis: ["😀", "😢", "😉", "😂", "😊", "🤪", "😍", "🥳", "🤩"]),
            Theme(name: "Food", icon: "cart", emojis: ["🍏", "🍆", "🍒", "🍇", "🍓", "🫐", "🌽", "🥩", "🍝", "🍔"]),
            Theme(name: "Transport", icon: "car", emojis: ["🚗", "✈️", "🚲", "⛵️", "🚌", "🚁", "🚀", "🛸", "🚇"])
        ]
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
//            HStack() {
//                ForEach(ContentView.themes) { theme in
//                    ThemeButton(name: theme.name, icon: theme.icon) {
//                        emojis = theme.emojis.shuffled()
//                        emojiCount = Int.random(in: 4..<theme.emojis.count)
//                    }
//                    if theme != ContentView.themes.last {
//                        Spacer()
//                    }
//                }
//            }
//            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
    }
}

struct Theme: Equatable, Identifiable {
    var id = UUID()
    
    let name: String
    let icon: String
    let emojis: [String]
}

struct ThemeButton: View {
    let name: String
    let icon: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: icon).font(.largeTitle)
                Text(name).font(.caption)
            }
        }
    }
}

// MARK: Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
