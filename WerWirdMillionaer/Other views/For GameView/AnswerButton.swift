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
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.trailing, 15)
        .padding(.leading, 15)
        .background(
            ZStack {
                AnswerButtonShape()
                    .fill(Color(hue: 0.5881, saturation: 0.8945, brightness: 0.9294))
                
                AnswerButtonShape()
                    .stroke(Color(hue: 0.6381, saturation: 0.1452, brightness: 0.9451), lineWidth: 3)
            }
        )
        .disabled(true)
    }
}


struct AnswerButton: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData

    @State var showingAnswer: String = ""
    @State var showOpacity: Double = 1
    
    var answerName: String
    var showingAnswerIndex: Int // Index of the possible answer which is shown
    
    init(answerName: String, _ showingIndex: Int) {
        self.answerName = answerName
        self.showingAnswerIndex = showingIndex
    }
    
    func buttonPressedAction(answerCorrect: Bool) {
        if gameStateData.timeRemaining != 0 && !(gameStateData.timeRemaining < 0) {
            gameStateData.timeKeepCounting = false
            gameStateData.answerSubmitted = showingAnswer
            soundManager.playSoundEffect(soundUrl: getAnswerSubmittedUrl())
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                gameStateData.questionAnsweredCorrectly = answerCorrect
            }
        }
    }
    
    func getButtonBackgroundColor() -> Color {
        if gameStateData.questionAnsweredCorrectly == true && showingAnswer == gameStateData.randomQuestion.correctAnswer {
            return Color(hue: 0.3244, saturation: 0.7222, brightness: 0.7059)
        } else if gameStateData.questionAnsweredCorrectly == false && showingAnswer == gameStateData.answerSubmitted {
            return Color.red
        } else if gameStateData.answerSubmitted != nil && gameStateData.answerSubmitted == showingAnswer {
            return Color(red: 1, green: 0.62, blue: 0)
        } else {
            return Color(hue: 0.5881, saturation: 0.8945, brightness: 0.9294)
        }
    }
    
    var body: some View {
        Button(action: {
            if gameStateData.randomQuestion.correctAnswer == showingAnswer {
                buttonPressedAction(answerCorrect: true)
            } else {
                buttonPressedAction(answerCorrect: false)
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
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.trailing, 15)
        .padding(.leading, 15)
        .disabled(gameStateData.answerSubmitted != nil ? true : false)
        .background(
            ZStack {
                AnswerButtonShape()
                    .fill(getButtonBackgroundColor())
                
                if gameStateData.questionAnsweredCorrectly == false && showingAnswer == gameStateData.randomQuestion.correctAnswer {
                    AnswerButtonShape()
                        .fill(Color(red: 0.21, green: 0.91, blue: 0))
                        .opacity(showOpacity)
                        .animation(Animation.easeInOut(duration: 0.4).repeatForever())
                        .onAppear {
                            withAnimation(Animation.easeInOut.repeatForever()) {
                                showOpacity = 0
                            }
                        }
                }
                
                AnswerButtonShape()
                    .stroke(Color(hue: 0.6381, saturation: 0.1452, brightness: 0.9451), lineWidth: 3)
            }
        )
    }
}
