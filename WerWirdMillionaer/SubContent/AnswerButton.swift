//
//  AnswerButton.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import AVFoundation
import SwiftUI

struct QuestionTextView: View {
    var currentPrizesLevel: CurrentPrizesLevel
    
    init(currentPrizesLevel: CurrentPrizesLevel) {
        self.currentPrizesLevel = currentPrizesLevel
    }
    
    var body: some View {
        Button(action: {}) {
            Text(currentPrizesLevel.randomQuestion.question)
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
    var currentPrizesLevel: CurrentPrizesLevel
    var showingAnswer: String?
    
    init(jokerGuess: Binding<String>, answerName: String, showingIndex: Int, currentPrizesLevel: CurrentPrizesLevel) {
        self._jokerGuess = jokerGuess
        self.answerName = answerName
        self.showingAnswerIndex = showingIndex
        self.currentPrizesLevel = currentPrizesLevel
        
        if self.showingAnswerIndex == 0 {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answerA
        } else if self.showingAnswerIndex == 1 {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answerB
        } else if self.showingAnswerIndex == 2 {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answerC
        } else {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answerD
        }
    }
    
    var body: some View {
        Button(action: {
            if currentPrizesLevel.randomQuestion.correctAnswer == showingAnswer {
                print("Correct!")
                currentPrizesLevel.timeKeepCounting = false
                currentPrizesLevel.questionAnsweredCorrectly = true
            } else {
                print("Wrong!")
                currentPrizesLevel.timeKeepCounting = false
                currentPrizesLevel.questionAnsweredCorrectly = false
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
