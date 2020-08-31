//
//  ButtonShape.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct QuestionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding(.trailing, 15)
            .padding(.leading, 15)
            .background(
                ZStack {
                    ButtonShape()
                        .fill(Color(hue: 0.5881, saturation: 0.8945, brightness: 0.9294))
                    
                    ButtonShape()
                        .stroke(Color.black, lineWidth: 3)
                }
            )
    }
}

struct ButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.size.width
            let height = rect.size.height
            
            let button_width: CGFloat
            if width > 500 {
                button_width = width / 20
            } else {
                button_width = width / 9
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
        Group {
//            ButtonShape()
//                .fill(Color.green)
//            ButtonShape()
//                .stroke(Color.black, lineWidth: 2)
            
            Button(action: {}) {
                Text("Antwort A: Irgendeine Antwort")
                    .foregroundColor(Color.white)
            }.buttonStyle(QuestionButtonStyle())
        }
    }
}
