//
//  AnswerButton.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import AVFoundation
import SwiftUI

struct AnswerButton: View {
    @EnvironmentObject var soundPlayer: SoundPlayer
    
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
            var questionCorrect = false
            if currentPrizesLevel.randomQuestion.correct_answer == showingAnswer {
                print("Correct!")
                currentPrizesLevel.changePrizeLevelIndicator = true
                questionCorrect = true
            } else {
                print("Wrong!")
            }
            
            // Play sound
            let soundUrl = getQuestionAudioUrl(prizeLevel: currentPrizesLevel.currentPrizeLevel, isCorrect: questionCorrect)
            soundPlayer.playSound(soundUrl: soundUrl)
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
