//
//  Face.swift
//  Set
//
//  Created by Alexander Ostrovsky on 22.07.2022.
//

import SwiftUI

struct Face: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.addArc(center: center, radius: rect.width/3, startAngle: Angle.zero, endAngle: Angle.degrees(360), clockwise: true)
        return path
    }
}
