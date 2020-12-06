//
//  ButtonShape.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct AnswerButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.size.width
            let height = rect.size.height
            let buttonWidth = width
            
            let buttonEdgeWidth: CGFloat
            if buttonWidth > 500 {
                buttonEdgeWidth = buttonWidth / 18
            } else {
                buttonEdgeWidth = buttonWidth / 9
            }
            
            path.move(to: CGPoint(x: 0, y: height / 2))
            path.addLine(to: CGPoint(x: buttonEdgeWidth, y: 0))
            path.addLine(to: CGPoint(x: buttonWidth - buttonEdgeWidth, y: 0))
            path.addLine(to: CGPoint(x: buttonWidth, y: height / 2))
            path.addLine(to: CGPoint(x: buttonWidth - buttonEdgeWidth, y: height))
            path.addLine(to: CGPoint(x: buttonEdgeWidth, y: height))
            path.addLine(to: CGPoint(x: 0, y: height / 2))
        }
    }
}

struct AnswerButtonShapeDividerLine: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.size.width
            let height = rect.size.height
            let lineHeight = height / 250
            let startHeight = (height / 2) - (lineHeight / 2)

            path.move(to: CGPoint(x: 0, y: startHeight))
            path.addRect(CGRect(x: 0, y: startHeight, width: width, height: lineHeight))
        }
    }
}
