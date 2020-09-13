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
        .buttonStyle(AnswerButtonStyle())
        .disabled(true)
    }
}


struct AnswerButton: View {
    @EnvironmentObject var soundManager: SoundManager
    
    @Binding var jokerGuess: String
    var answerName: String
    var showingAnswerIndex: Int // Index of the possible answer which is shown
    var gameStateData: GameStateData
    var showingAnswer: String?
    
    init(jokerGuess: Binding<String>, answerName: String, showingIndex: Int, gameStateData: GameStateData) {
        self._jokerGuess = jokerGuess
        self.answerName = answerName
        self.showingAnswerIndex = showingIndex
        self.gameStateData = gameStateData
        
        if self.showingAnswerIndex == 0 {
            self.showingAnswer = self.gameStateData.randomQuestion.answerA
        } else if self.showingAnswerIndex == 1 {
            self.showingAnswer = self.gameStateData.randomQuestion.answerB
        } else if self.showingAnswerIndex == 2 {
            self.showingAnswer = self.gameStateData.randomQuestion.answerC
        } else {
            self.showingAnswer = self.gameStateData.randomQuestion.answerD
        }
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
                
                if showingAnswer != nil {
                    HStack(spacing: 0) {
                        Text(showingAnswer!)
                            .foregroundColor(Color.white)
                            .lineLimit(2)
                            .font(.headline)
                    }
                    .fixedSize(horizontal: true, vertical: true)
                    
                    Spacer()
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .buttonStyle(AnswerButtonStyle())
    }
}
