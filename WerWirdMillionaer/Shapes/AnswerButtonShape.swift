//
//  ButtonShape.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct AnswerButtonStyle: ButtonStyle {
    @State var answeredFalseOpacity: Bool = false
    
    var answerSubmitted: String?
    var questionAnsweredCorrectly: Bool?
    var showingAnswer: String
    var correctAnswer: String
    
    init(answerSubmitted: String? = nil, questionAnsweredCorrectly: Bool? = nil, showingAnswer: String = "", correctAnswer: String = "") {
        self.answerSubmitted = answerSubmitted
        self.questionAnsweredCorrectly = questionAnsweredCorrectly
        self.showingAnswer = showingAnswer
        self.correctAnswer = correctAnswer
    }
    
    func getButtonBackgroundColor() -> Color {
        if questionAnsweredCorrectly == true && showingAnswer == correctAnswer {
            return Color(hue: 0.3244, saturation: 0.7222, brightness: 0.7059)
        } else if questionAnsweredCorrectly == false && showingAnswer == answerSubmitted {
            return Color.red
        } else if answerSubmitted != nil && answerSubmitted == showingAnswer {
            return Color.yellow
        } else {
            return Color(hue: 0.5881, saturation: 0.8945, brightness: 0.9294)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .padding(.trailing, 15)
            .padding(.leading, 15)
            .background(
                ZStack {
                    if questionAnsweredCorrectly == false {
                        AnswerButtonShape()
                            .fill(getButtonBackgroundColor())
                    }
                    
                    AnswerButtonShape()
                        .fill(getButtonBackgroundColor())
                        .scaleEffect(answeredFalseOpacity ? 0.5 : 1)
                    
                    AnswerButtonShape()
                        .stroke(Color(hue: 0.6381, saturation: 0.1452, brightness: 0.9451), lineWidth: 3)
                }
            )
    }
}

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
