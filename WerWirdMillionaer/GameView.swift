//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class CurrentPrizesLevel: ObservableObject {
    @Published var currentPrizeLevel: Int = 0
    @Published var oldCurrentPrizeLevel: Int = -1
    @Published var changePrizeLevelIndicator = false
    @Published var randomQuestion = Question(question: "", answerA: "", answerB: "", answerC: "", answerD: "", correctAnswer: "")
    @Published var longestAnswer: Int = 0 // Used to correctly use the exact amount of space for each answer
    
    @Published var telephoneJokerActive = true
    @Published var audienceJokerActive = true
    @Published var showAudienceJokerData = false
    @Published var audienceJokerData = AudiencePollCollection()
    @Published var fiftyfiftyJokerActive = true
    
    func nextPrizeLevel() {
        if currentPrizeLevel + 2 <= questionData!.prizeLevels.count {
            self.currentPrizeLevel += 1
            oldCurrentPrizeLevel += 1
        } else {
            print("Maximum prize level reached. Staying on \(currentPrizeLevel) prize level")
        }
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel].questions.randomElement()!
    }
}

struct GameView: View {
    @EnvironmentObject var soundManager: SoundManager
    
    @State var jokerGuess: String = ""
    @ObservedObject var currentPrizesLevel = CurrentPrizesLevel()
    
    var prizesLoadedSuccessful: Bool = false

    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.locale = Locale(identifier: "de_De")
        return numberFormatter
    }
    
    init() {
        if questionData != nil {
            prizesLoadedSuccessful = true
        } else {
            prizesLoadedSuccessful = false
        }
        
        currentPrizesLevel.updateRandomQuestion()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
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
                                        currentPrizesLevel.changePrizeLevelIndicator = false
                                        currentPrizesLevel.showAudienceJokerData = false
                                        currentPrizesLevel.audienceJokerData = AudiencePollCollection()
                                        jokerGuess = ""
                                        currentPrizesLevel.nextPrizeLevel()
                                        currentPrizesLevel.updateRandomQuestion()
                                        let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: currentPrizesLevel.currentPrizeLevel, oldCurrentPrizeLevel: currentPrizesLevel.oldCurrentPrizeLevel)
                                        print(backgroundSoundUrl)
                                        soundManager.playSound(soundUrl: backgroundSoundUrl, loops: -1)
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
                        
                        HStack {
                            HStack(spacing: 0) {
                                VStack(spacing: 40) {
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort A", showingIndex: 0, currentPrizesLevel: currentPrizesLevel)
                                    
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort B", showingIndex: 1, currentPrizesLevel: currentPrizesLevel)
                                }
                                
                                VStack(spacing: 40) {
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort C", showingIndex: 2, currentPrizesLevel: currentPrizesLevel)
                                
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort D", showingIndex: 3, currentPrizesLevel: currentPrizesLevel)
                                }
                            }
                        }.padding(.top, 40)
                        
                        Spacer()
                    }
                } else {
                    Text("Fragen konnten nicht geladen werden.")
                }
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .animation(.easeInOut(duration: 0.2))
            
            if currentPrizesLevel.showAudienceJokerData {
                HStack(alignment: .bottom, spacing: 20) {
                    ForEach(currentPrizesLevel.audienceJokerData.votingVariant, id: \.self) { pollSection in
                        VStack {
                            Text((numberFormatter.string(from: pollSection.probability) != nil) ? numberFormatter.string(from: pollSection.probability)! : "")
                                .foregroundColor(Color.white)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .bottom, endPoint: .top))
                                .frame(width: currentPrizesLevel.audienceJokerData.width, height: pollSection.height)
                            
                            Text(pollSection.name)
                                .font(.title)
                                .bold()
                                .foregroundColor(Color(hue: 0.0764, saturation: 0.8571, brightness: 0.9882))
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.87))
                .cornerRadius(10)
                .padding(.top, 220)
            }
        }
        .onAppear {
            let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: currentPrizesLevel.currentPrizeLevel, oldCurrentPrizeLevel: currentPrizesLevel.oldCurrentPrizeLevel)
            soundManager.playSound(soundUrl: backgroundSoundUrl, loops: -1)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
