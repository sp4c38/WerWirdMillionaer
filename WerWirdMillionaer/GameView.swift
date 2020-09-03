//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

class CurrentPrizesLevel: ObservableObject {
    @Published var currentPrizeLevel: Int = 0
    @Published var changePrizeLevelIndicator = false
    @Published var randomQuestion = Question(question: "", answer_a: "", answer_b: "", answer_c: "", answer_d: "", correct_answer: "")
    @Published var telephoneJokerActive = true
    @Published var audienceJokerActive = true
    @Published var fiftyfiftyJokerActive = true
    
    func nextPrizeLevel() {
        if currentPrizeLevel + 2 <= questionData!.prizeLevels.count {
            self.currentPrizeLevel += 1
        } else {
            print("Maximum prize level reached. Staying on \(currentPrizeLevel) prize level")
        }
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel].questions.randomElement()!
    }
}

struct GameView: View {
    @State var jokerGuess: String = ""
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
        ZStack {
            VStack {
                if prizesLoadedSuccessful {
                    HStack(spacing: 40) {
                        Spacer()
                        
                        if currentPrizesLevel.changePrizeLevelIndicator {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.white)
                                .frame(width: 40)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                        currentPrizesLevel.nextPrizeLevel()
                                        currentPrizesLevel.updateRandomQuestion()
                                        currentPrizesLevel.changePrizeLevelIndicator = false
                                    }
                                }
                        }
                        
                        Text(prizesData.prizeLevels[currentPrizesLevel.currentPrizeLevel].name)
                            .font(.largeTitle)
                            .foregroundColor(currentPrizesLevel.changePrizeLevelIndicator ? Color.white : Color.black)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(currentPrizesLevel.changePrizeLevelIndicator ? Color(hue: 0.0814, saturation: 0.8821, brightness: 0.9647) : Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .transition(.opacity)
                    
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 50) {
                            JokerButtonsView(jokerGuess: $jokerGuess, currentPrizesLevel: currentPrizesLevel)
                            
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
                        
                        if jokerGuess != "" {
                            Text(jokerGuess)
                        }
                        
                        HStack(spacing: 100) {
                            VStack(spacing: 40) {
                                AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort A", showingIndex: 0, currentPrizesLevel: currentPrizesLevel)
                                AnswerButton(jokerGuess: $jokerGuess,answerName: "Antwort B", showingIndex: 1, currentPrizesLevel: currentPrizesLevel)
                            }
                            
                            VStack(spacing: 40) {
                                AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort C", showingIndex: 2, currentPrizesLevel: currentPrizesLevel)
                                AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort D", showingIndex: 3, currentPrizesLevel: currentPrizesLevel)
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
            .animation(.easeInOut(duration: 0.2))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
