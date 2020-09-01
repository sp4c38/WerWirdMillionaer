//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

class CurrentPrizesLevel: ObservableObject {
    @Published var currentPrizeLevel: Int = 0
    @Published var randomQuestion = Question(question: "", answer_a: "", answer_b: "", answer_c: "", answer_d: "", correct_answer: "")
    
    func nextPrizeLevel() {
        self.currentPrizeLevel += 1
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel].questions.randomElement()!
    }
}

struct AnswerButton: View {
    var answerName: String
    var showingAnswerIndex: Int // Index of the possible answer which is shown
    var currentPrizesLevel: CurrentPrizesLevel
    var showingAnswer: String
    
    init(answerName: String, showingIndex: Int, currentPrizesLevel: CurrentPrizesLevel) {
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
                Text(prizesData.prizeLevels[currentPrizesLevel.currentPrizeLevel].name)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 50) {
                        VStack {
                            Button(action: {
                                
                            }) {
                                Image("audience")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                            
                            Button(action: {}
                            ) {
                                Image("telephone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                            
                            Button(action: {
                                
                            }) {
                                Image("50-50")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }
                        }
                        
                        VStack(spacing: 0) {
                            Text("Frage")
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
                        .frame(maxWidth:. infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                    }
                    
                    HStack(spacing: 100) {
                        VStack(spacing: 40) {
                            AnswerButton(answerName: "Antwort A", showingIndex: 0, currentPrizesLevel: currentPrizesLevel)
                            AnswerButton(answerName: "Antwort B", showingIndex: 1, currentPrizesLevel: currentPrizesLevel)
                        }
                        
                        VStack(spacing: 40) {
                            AnswerButton(answerName: "Antwort C", showingIndex: 2, currentPrizesLevel: currentPrizesLevel)
                            AnswerButton(answerName: "Antwort D", showingIndex: 3, currentPrizesLevel: currentPrizesLevel)
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
        .padding(30)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
