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

struct AnswerButton: View {

    var answerName: String
    var showingAnswerIndex: Int // Index of the possible answer which is shown
    var question: Question
    var showingAnswer: String
    
    init(answerName: String, showingIndex: Int, question: Question) {
        self.answerName = answerName
        self.showingAnswerIndex = showingIndex
        self.question = question
        
        if self.showingAnswerIndex == 0 {
            self.showingAnswer = self.question.answer_a
        } else if self.showingAnswerIndex == 1 {
            self.showingAnswer = self.question.answer_b
        } else if self.showingAnswerIndex == 2 {
            self.showingAnswer = self.question.answer_c
        } else {
            self.showingAnswer = self.question.answer_d
        }
    }
    
    var body: some View {
        Button(action: {
            
        }) {
            HStack(spacing: 20) {
                Text(answerName)
                    .font(.subheadline)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                
                Spacer()
                
                Text(showingAnswer)
                    .fixedSize(horizontal: true, vertical: true)
                    .lineLimit(2)
                    .font(.headline)
                    .foregroundColor(Color.white)
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
        }
        .buttonStyle(QuestionButtonStyle())
    }
}

struct GameView: View {
    @ObservedObject var currentPrizesLevel = CurrentPrizesLevel()
    var prizesLoadedSuccessful: Bool = false
    
    init() {
        if questionData != nil {
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
                    
                    VStack(spacing: 0) {
                        HStack { () -> Text in 
                            print(prizesData.prizeLevels[0]["name"])
                            return Text("Frage")
                        }
                        .font(.title)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        
                        Text(currentPrizesLevel.randomQuestion.question)
                            .font(.title2)
                            .shadow(radius: 5)
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    .background(Color.red)
                    .cornerRadius(10)
                    
                    HStack(spacing: 100) {
                        VStack(spacing: 40) {
                            AnswerButton(answerName: "Antwort A", showingIndex: 0, question: currentPrizesLevel.randomQuestion)
                            AnswerButton(answerName: "Antwort B", showingIndex: 1, question: currentPrizesLevel.randomQuestion)
                        }
                        
                        VStack(spacing: 40) {
                            AnswerButton(answerName: "Antwort C", showingIndex: 2, question: currentPrizesLevel.randomQuestion)
                            AnswerButton(answerName: "Antwort D", showingIndex: 3, question: currentPrizesLevel.randomQuestion)
                        }
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }
            } else {
                Text("Fragen konnten nicht geladen werden.")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(50)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
