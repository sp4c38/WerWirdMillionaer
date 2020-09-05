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
    
    @Published var questionAnsweredCorrectly: Bool? = nil
    
    @Published var randomQuestion = Question(question: "", answerA: "", answerB: "", answerC: "", answerD: "", correctAnswer: "")
    
    @Published var timeRemaining = 30 // Remaining time in seconds
    @Published var timeKeepCounting = true // Indicates if the timer counts
    @Published var timeOver = false // Set to true if the time is over
    
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
                        
                        if currentPrizesLevel.questionAnsweredCorrectly == true {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.white)
                                .frame(width: 40)
                                .onAppear {
                                    // Play the sound effect which indicates that the question was answered correctly immediately
                                    let soundEffectUrl = getQuestionAudioUrl(prizeLevel: currentPrizesLevel.currentPrizeLevel, isCorrect: true)
                                    soundManager.playSoundEffect(soundUrl: soundEffectUrl)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                        // Reset all data for next round
                                        currentPrizesLevel.questionAnsweredCorrectly = nil
                                        
                                        currentPrizesLevel.showAudienceJokerData = false
                                        currentPrizesLevel.audienceJokerData = AudiencePollCollection()
                                        jokerGuess = ""
                                        
                                        currentPrizesLevel.timeOver = false
                                        currentPrizesLevel.timeKeepCounting = true
                                        currentPrizesLevel.timeRemaining = 30
                                        
                                        currentPrizesLevel.nextPrizeLevel()
                                        currentPrizesLevel.updateRandomQuestion()
                                        
                                        let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: currentPrizesLevel.currentPrizeLevel, oldCurrentPrizeLevel: currentPrizesLevel.oldCurrentPrizeLevel)
                                        soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
                                    }
                                }
                        } else if currentPrizesLevel.timeOver == true || currentPrizesLevel.questionAnsweredCorrectly == false {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.white)
                                .frame(width: 40)
                                .onAppear {
                                    print(currentPrizesLevel.questionAnsweredCorrectly)
                                    print(currentPrizesLevel.timeOver)
                                    let soundEffectUrl = getQuestionAudioUrl(prizeLevel: currentPrizesLevel.currentPrizeLevel, isCorrect: false)
                                    soundManager.playSoundEffect(soundUrl: soundEffectUrl)
                                }
                        }
                        
                        Text(prizesData.prizeLevels[currentPrizesLevel.currentPrizeLevel].name)
                            .font(.largeTitle)
                            .foregroundColor((currentPrizesLevel.questionAnsweredCorrectly != nil) ? Color.white : Color.black)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((currentPrizesLevel.questionAnsweredCorrectly != nil) ? Color(hue: 0.0814, saturation: 0.8821, brightness: 0.9647) : Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.bottom, 30)
            
                    VStack {
                        HStack {
                            JokerButtonsView(jokerGuess: $jokerGuess, currentPrizesLevel: currentPrizesLevel)
                            
                            Spacer()
                            
                            TimeRemainingCircleView(currentPrizesLevel: currentPrizesLevel)
                            
                            Spacer()
                        }
                        
                        if jokerGuess != "" {
                            Text(jokerGuess)
                        }
                        
                        VStack {
                            QuestionTextView(currentPrizesLevel: currentPrizesLevel)
                                .padding(.bottom, 20)
                            
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
            .padding(40)
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
                .padding(50)
                .background(Color.black.opacity(0.87))
                .cornerRadius(10)
                .padding(.top, 220)
            }
        }
        .onAppear {
            // Comment when using Canvas
            let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: currentPrizesLevel.currentPrizeLevel, oldCurrentPrizeLevel: currentPrizesLevel.oldCurrentPrizeLevel)
            soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
