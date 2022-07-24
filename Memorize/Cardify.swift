//
//  Cardify.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 24.07.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                content
            } else {
                shape.fill()
            }
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius = 10.0
        static let lineWidth = 3.0
    }

}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return modifier(Cardify(isFaceUp: isFaceUp))
    }
}
