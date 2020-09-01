//
//  AnswerButton.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import SwiftUI

struct AnswerButton: View {
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
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answer_a
        } else if self.showingAnswerIndex == 1 {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answer_b
        } else if self.showingAnswerIndex == 2 {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answer_c
        } else {
            self.showingAnswer = self.currentPrizesLevel.randomQuestion.answer_d
        }
    }
    
    var body: some View {
        Button(action: {
            if currentPrizesLevel.randomQuestion.correct_answer == showingAnswer {
                print("Correct!")
                currentPrizesLevel.nextPrizeLevel()
                currentPrizesLevel.updateRandomQuestion()
                jokerGuess = ""
            } else {
                print("Wrong!")
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
                
                if (showingAnswer != nil) {
                    Text(showingAnswer!)
                        .fixedSize(horizontal: true, vertical: true)
                        .lineLimit(2)
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .buttonStyle(QuestionButtonStyle())
    }
}
