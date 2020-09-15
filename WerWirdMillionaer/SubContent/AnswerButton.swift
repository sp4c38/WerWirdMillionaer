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
        .buttonStyle(AnswerButtonStyle(isCorrectAndSelected: false))
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
    
    init(answerName: String, showingIndex: Int) {
        self.answerName = answerName
        self.showingAnswerIndex = showingIndex
    }
    
    var body: some View {
        Button(action: {
            if gameStateData.randomQuestion.correctAnswer == showingAnswer {
                print("Correct!")
                gameStateData.timeKeepCounting = false
                gameStateData.questionAnsweredCorrectly = true
            } else {
                print("Wrong!")
                gameStateData.timeKeepCounting = false
                gameStateData.questionAnsweredCorrectly = false
            }
        }) {
            HStack(spacing: 20) {
                Text(answerName)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: true)
                    .font(.subheadline)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    
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
                if gameStateData.randomQuestion.answerA != nil {
                    showingAnswer = gameStateData.randomQuestion.answerA!
                }
            } else if showingAnswerIndex == 1 {
                if gameStateData.randomQuestion.answerB != nil {
                    showingAnswer = gameStateData.randomQuestion.answerB!
                }
            } else if showingAnswerIndex == 2 {
                if gameStateData.randomQuestion.answerC != nil {
                    showingAnswer = gameStateData.randomQuestion.answerC!
                }
            } else {
                if gameStateData.randomQuestion.answerD != nil {
                    showingAnswer = gameStateData.randomQuestion.answerD!
                }
            }
        }
        .onChange(of: gameStateData.randomQuestion) { _ in
            if showingAnswerIndex == 0 {
                if gameStateData.randomQuestion.answerA != nil {
                    showingAnswer = gameStateData.randomQuestion.answerA!
                }
            } else if showingAnswerIndex == 1 {
                if gameStateData.randomQuestion.answerB != nil {
                    showingAnswer = gameStateData.randomQuestion.answerB!
                }
            } else if showingAnswerIndex == 2 {
                if gameStateData.randomQuestion.answerC != nil {
                    showingAnswer = gameStateData.randomQuestion.answerC!
                }
            } else {
                if gameStateData.randomQuestion.answerD != nil {
                    showingAnswer = gameStateData.randomQuestion.answerD!
                }
            }
        }
        .buttonStyle(AnswerButtonStyle(isCorrectAndSelected: (gameStateData.questionAnsweredCorrectly == true && gameStateData.randomQuestion.correctAnswer == showingAnswer) ? true : false))
    }
}
