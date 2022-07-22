//
//  Face.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import SwiftUI

struct Face: View {
    let number: SetGame.Card.Number
    let shape: SetGame.Card.Shape
    let shading: SetGame.Card.Shading
    let color: SetGame.Card.Color
    
    var body: some View {
        GeometryReader { geometry in
            OvalShape()
                .stroke(lineWidth: max(2.0, round(geometry.size.width / 100)))
                .foregroundColor(Color(from: color))
        }
//        GeometryReader { geometry in
//            Path() { path in
//            }.foregroundColor(Color(from: color))
//        }
    }
}

struct OvalShape: Shape {
    var oval: Path {
        let size = CGSize(width: 0.5, height: 0.25)
        
        var path = Path()
        
        path.addRoundedRect(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), cornerSize: CGSize(width: size.height / 2, height: size.height / 2))
        
        return path
    }
    
    var diamond: Path {
        let size = CGSize(width: 0.5, height: 0.25)

        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: -size.height / 2))
        path.addLine(to: CGPoint(x: -size.width / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: size.height / 2))
        path.addLine(to: CGPoint(x: size.width / 2, y: 0))
        path.closeSubpath()
        
        return path
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addPath(diamond, transform: CGAffineTransform(translationX: rect.midX, y: rect.midY).scaledBy(x: rect.width, y: rect.width))
        path.addPath(oval, transform: CGAffineTransform(translationX: rect.midX, y: rect.midY - rect.height / 5).scaledBy(x: rect.width, y: rect.width))
        path.addPath(oval, transform: CGAffineTransform(translationX: rect.midX, y: rect.midY + rect.height / 5).scaledBy(x: rect.width, y: rect.width))
        return path
    }
}

private extension Color {
    init(from cardColor: SetGame.Card.Color) {
        switch cardColor {
        case .red: self = .red
        case .green: self = .green
        case .purple: self = .purple
        }
    }
}

private extension Int {
    init(_ number: SetGame.Card.Number) {
        switch number {
        case .one: self = 1
        case .two: self = 2
        case .three: self = 3
        }
    }
}

// MARK: - Previews

struct Previews_Face_Previews: PreviewProvider {
    static var previews: some View {
        Face(number: .three, shape: .oval, shading: .open, color: .purple)
    }
}