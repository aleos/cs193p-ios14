//
//  Face.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import SwiftUI

struct Face: View {
    typealias Card = SetGameViewModel.Card
    
    let number: SetGameViewModel.Card.Number
    let shape: SetGameViewModel.Card.Shape
    let shading: SetGameViewModel.Card.Shading
    let color: SetGameViewModel.Card.Color
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                CardShape(shape: shape, number: number)
                    .stroke(lineWidth: max(2.0, round(geometry.size.width / 100)))
                    .frame(height: geometry.size.height / 2, alignment: .center)
                    .foregroundColor(Color(from: color))
                Spacer()
            }
        }
    }
}

struct CardShape: Shape {
    let shape: SetGameViewModel.Card.Shape
    let number: SetGameViewModel.Card.Number
    
    private static let oval: Path = {
        let size = CGSize(width: 0.5, height: 0.25)
        
        var path = Path()
        
        path.addRoundedRect(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), cornerSize: CGSize(width: size.height / 2, height: size.height / 2))
        
        return path
    }()
    
    private static let diamond: Path = {
        let size = CGSize(width: 0.5, height: 0.25)

        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: -size.height / 2))
        path.addLine(to: CGPoint(x: -size.width / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: size.height / 2))
        path.addLine(to: CGPoint(x: size.width / 2, y: 0))
        path.closeSubpath()
        
        return path
    }()
    
    private static let squiggle: Path = {
        struct Constants {
            static let lineWidth = 0.12
        }
        
        let size = CGSize(width: 0.5, height: 0.25)

        var path = Path()
        
        path.move(to: CGPoint(x: -size.width * (0.5 - Constants.lineWidth), y: 0))
        path.addQuadCurve(to: CGPoint(x: 0, y: 0), control: CGPoint(x: -size.width * (0.25 - Constants.lineWidth / 2), y: -size.width / 4))
        path.addQuadCurve(to: CGPoint(x: size.width * (0.5 - Constants.lineWidth), y: 0), control: CGPoint(x: size.width * (0.25 - Constants.lineWidth / 2), y: size.width / 4))
        path = path.strokedPath(StrokeStyle(lineWidth: Constants.lineWidth, lineCap: CGLineCap.round))
        
        return path
    }()
    
    func path(in rect: CGRect) -> Path {
        let shapePath: Path = {
            switch shape {
            case .diamond: return Self.diamond
            case .squiggle: return Self.squiggle
            case .oval: return Self.oval
            }
        }()
        let shapesCount = Int(number)
        let shapeHeight = rect.width / 3
        let maxDistance = shapeHeight * CGFloat(shapesCount - 1)
        let minOffset = -maxDistance / 2
        var path = Path()
        for i in 0..<shapesCount {
            let transform = CGAffineTransform(
                translationX: rect.midX,
                y: rect.midY + minOffset + shapeHeight * CGFloat(i)
            ).scaledBy(x: rect.width, y: rect.width)
            path.addPath(shapePath.applying(transform))
        }
        
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
