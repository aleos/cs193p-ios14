//
//  ContentView.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 14.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["🚗", "✈️", "🚲", "⛵️", "🚌", "🚁", "🚀", "🛸", "🚇", "👻", "🎃", "🕷", "💀", "😱", "🧟", "🦇", "🪦", "🩸", "🔮", "🕯", "🧛"]
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
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack() {
                ForEach(ContentView.themes) { theme in
                    ThemeButton(name: theme.name, icon: theme.icon) {
                        emojis = theme.emojis.shuffled()
                        emojiCount = theme.emojis.count
                    }
                    if theme != ContentView.themes.last {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
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

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

// MARK: Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
