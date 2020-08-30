//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

class CurrentPrizesLevel: ObservableObject {
    var currentPrizeLevel: Int = 0
    var randomQuestion = Question(question: "", answer_a: "", answer_b: "", answer_c: "", answer_d: "", correct_answer: "")
    
    func updateRandomQuestion() {
        randomQuestion = getRandomQuestion(currentPrizeLevel: currentPrizeLevel)
    }
}

struct GameView: View {
    @ObservedObject var currentPrizesLevel = CurrentPrizesLevel()
    var prizesLoadedSuccessful: Bool = false
    
    init() {
        if prizesData != nil {
            prizesLoadedSuccessful = true
        } else {
            prizesLoadedSuccessful = false
        }
        
        currentPrizesLevel.updateRandomQuestion()
    }
    
    var body: some View {
        VStack {
            if prizesLoadedSuccessful {
                VStack {
                    Spacer()
                    
                    Text("Frage: \(currentPrizesLevel.randomQuestion.question)")
                    
                    HStack(spacing: 100) {
                        VStack(spacing: 40) {
                            Button(action: {}) {
                                Text("Antwort A: \(currentPrizesLevel.randomQuestion.answer_a)")
                                    .foregroundColor(Color.white)
                            }
                            .buttonStyle(QuestionButtonStyle())
                            
                            sa
                            Button(action: {}) {
                                Text("Antwort B: \(currentPrizesLevel.randomQuestion.answer_b)")
                                    .foregroundColor(Color.white)
                            }
                            .buttonStyle(QuestionButtonStyle())
                            
                        }
                    
                        
                        VStack(spacing: 40) {
                            Button(action: {}) {
                                Text("Antwort C: \(currentPrizesLevel.randomQuestion.answer_c)")
                                    .foregroundColor(Color.white)
                            }
                            .buttonStyle(QuestionButtonStyle())
                            
                            Button(action: {}) {
                                Text("Antwort D: \(currentPrizesLevel.randomQuestion.answer_d)")
                                    .foregroundColor(Color.white)
                            }
                            .buttonStyle(QuestionButtonStyle())
                        }
                    }
                    .padding(.top, 50)
                }
            } else {
                Text("Fragen konnten nicht geladen werden.")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(50)
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
