//
//  ButtonShape.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct ButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.size.width
            let height = rect.size.height
            
            let button_width: CGFloat
            if width > 500 {
                button_width = width / 20
            } else {
                button_width = width / 5
            }
            
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addLine(to: CGPoint(x: button_width, y: 0))
            path.addLine(to: CGPoint(x: width - button_width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height / 2))
            path.addLine(to: CGPoint(x: width - button_width, y: height))
            path.addLine(to: CGPoint(x: button_width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height / 2))
        }
    }
}

struct ButtonShape_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                ButtonShape()
                    .fill(Color.green)
                ButtonShape()
                    .stroke(Color.black, lineWidth: 2)
            }
        }
    }
}
