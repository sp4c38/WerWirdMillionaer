//
//  AnswerButton.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import AVFoundation
import SwiftUI

struct QuestionTextView: View {
    var question: String
    
    var body: some View {
        Button(action: {}) {
            Text(question)
                .foregroundColor(Color.white)
                .lineLimit(2)
                .fixedSize(horizontal: true, vertical: true)
                .font(.headline)
                .padding(10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
        }
        .buttonStyle(AnswerButtonStyle(questionAnsweredCorrectly: nil))
        .disabled(true)
    }
}


struct AnswerButton: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData

    @State var showingAnswer: String = ""
    
    var answerName: String
    var showingAnswerIndex: Int // Index of the possible answer which is shown
    
    init(answerName: String, _ showingIndex: Int) {
        self.answerName = answerName
        self.showingAnswerIndex = showingIndex
    }
    
    var body: some View {
        Button(action: {
            if gameStateData.randomQuestion.correctAnswer == showingAnswer {
                gameStateData.timeKeepCounting = false
                gameStateData.questionAnsweredCorrectly = true
            } else {
                gameStateData.timeKeepCounting = false
                gameStateData.questionAnsweredCorrectly = false
            }
        }) {
            HStack(spacing: 20) {
                Text(answerName)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: true)
                    .font(.subheadline)
                    .padding(10)
                    .background(
                        Circle()
                            .foregroundColor(Color.white)
                    )
                    
                Spacer()
                    
                Text(showingAnswer)
                    .foregroundColor(Color.white)
                    .lineLimit(2)
                    .font(.headline)
                    .fixedSize(horizontal: true, vertical: true)
                        
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .onAppear {
            if showingAnswerIndex == 0 {
                showingAnswer = gameStateData.randomQuestion.answerA ?? ""
            } else if showingAnswerIndex == 1 {
                showingAnswer = gameStateData.randomQuestion.answerB ?? ""
            } else if showingAnswerIndex == 2 {
                showingAnswer = gameStateData.randomQuestion.answerC ?? ""
            } else {
                showingAnswer = gameStateData.randomQuestion.answerD ?? ""
            }
        }
        .onChange(of: gameStateData.randomQuestion) { newRandomQuestion in
            if showingAnswerIndex == 0 {
                showingAnswer = gameStateData.randomQuestion.answerA ?? ""
            } else if showingAnswerIndex == 1 {
                showingAnswer = gameStateData.randomQuestion.answerB ?? ""
            } else if showingAnswerIndex == 2 {
                showingAnswer = gameStateData.randomQuestion.answerC ?? ""
            } else {
                showingAnswer = gameStateData.randomQuestion.answerD ?? ""
            }
        }
        .buttonStyle(AnswerButtonStyle(questionAnsweredCorrectly: (gameStateData.randomQuestion.correctAnswer == showingAnswer) ? gameStateData.questionAnsweredCorrectly : nil))
    }
}
