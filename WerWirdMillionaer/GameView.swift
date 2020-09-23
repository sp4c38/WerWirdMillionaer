//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class GameStateData: ObservableObject {
    @Published var currentPrizeLevel: Int = 1
    @Published var oldCurrentPrizeLevel: Int = 0
    
    @Published var questionAnsweredCorrectly: Bool? = nil
    
    @Published var randomQuestion = Question(question: "", answerA: "", answerB: "", answerC: "", answerD: "", correctAnswer: "")
    @Published var randomQuestionAnswerIndexes = [Int]() // Will contain four unique numbers each time the question is updated to show the answer options randomly on the Game View
    
    @Published var timeAllAvailable = 30 // Time altogether avaliable to answer a question
    @Published var timeRemaining = 30 // Remaining time in seconds (must be same as timeAllAvailable)
    @Published var timeKeepCounting = true // Indicates if the timer counts
    @Published var timeOver = false // Set to true if the time is over
    @Published var coolDownTimerActive = false // Set to true if a cool down timer shall be activated, and than set to false
    
    @Published var telephoneJokerActive = true
    @Published var audienceJokerActive = true
    @Published var fiftyfiftyJokerActive = true
    @Published var showAudienceJokerData = false
    @Published var audienceJokerData = AudiencePollCollection()
    
    @Published var softStop: Bool? = nil // Is set to true if player pressed the stop button
                                         // Is set to false if player selected a wrong answer or the time expired
    
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
        self.randomQuestionAnswerIndexes = []
        for _ in 1...4 {
            var randomAnswerIndex = [0, 1, 2, 3].randomElement()!
            while self.randomQuestionAnswerIndexes.contains(randomAnswerIndex) {
                randomAnswerIndex = [0, 1, 2, 3].randomElement()!
            }
            
            self.randomQuestionAnswerIndexes.append(randomAnswerIndex)
        }
    }
    
    func changeCoolDownTimerActive() {
        withAnimation {
            self.coolDownTimerActive.toggle()
        }
    }
}

struct GameView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
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
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack(alignment: .center) {
                VStack {
                    if prizesLoadedSuccessful {
                        HStack(spacing: 40) {
                            Button(action: {
                                soundManager.stopAllSounds()

                                gameStateData.softStop = true
                                mainViewController.goToEndView()
                            }) {
                                Image("FinishedButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                            }

                            HStack(spacing: 40) {
                                Spacer()

                                if gameStateData.questionAnsweredCorrectly == true {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.white)
                                        .frame(width: 40)
                                        .onAppear {
                                            // Play the sound effect which indicates that the question was answered correctly immediately
                                            let soundEffectUrl = getQuestionAudioUrl(prizeLevel: gameStateData.currentPrizeLevel, isCorrect: true)
                                            soundManager.playSoundEffect(soundUrl: soundEffectUrl)

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                                // Reset all data for next round
                                                gameStateData.questionAnsweredCorrectly = nil

                                                gameStateData.showAudienceJokerData = false
                                                gameStateData.audienceJokerData = AudiencePollCollection()

                                                gameStateData.timeRemaining = gameStateData.timeAllAvailable
                                                gameStateData.changeCoolDownTimerActive()
                                                // When the cool down timer is finished other timer settings will be set from the CooldownView

                                                gameStateData.nextPrizeLevel()
                                                gameStateData.updateRandomQuestion()

                                                let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, oldCurrentPrizeLevel: gameStateData.oldCurrentPrizeLevel)
                                                soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
                                            }
                                        }
                                } else if gameStateData.timeOver == true || gameStateData.questionAnsweredCorrectly == false {
                                    Image(systemName: "multiply")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color.white)
                                        .frame(width: 40)
                                        .onAppear {
                                            let soundEffectUrl = getQuestionAudioUrl(prizeLevel: gameStateData.currentPrizeLevel, isCorrect: false)
                                            soundManager.playSoundEffect(soundUrl: soundEffectUrl)

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                                soundManager.stopAllSounds()

                                                gameStateData.softStop = false
                                                mainViewController.goToEndView()
                                            }
                                        }
                                }

                                Text("\(prizesData.prizeLevels[gameStateData.currentPrizeLevel].name)-Frage")
                                    .font(.largeTitle)
                                    .foregroundColor((gameStateData.questionAnsweredCorrectly != nil) ? Color.white : Color.black)

                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background((gameStateData.questionAnsweredCorrectly != nil) ? Color(hue: 0.0814, saturation: 0.8821, brightness: 0.9647) : Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                        .padding(.bottom, 30)

                        Spacer()
                        
                        VStack {
                            Spacer()

                            HStack {
                                JokerButtonsView(gameStateData: gameStateData)

                                Spacer()

                                TimeRemainingCircleView(gameStateData: gameStateData)

                                Spacer()
                            }

                            Spacer()

                            VStack {
                                QuestionTextView(question: gameStateData.randomQuestion.question)
                                    .padding(.bottom, 20)

                                HStack(spacing: 0) {
                                    VStack(spacing: 40) {
                                        AnswerButton(answerName: "A", showingIndex: gameStateData.randomQuestionAnswerIndexes[0])
                                        AnswerButton(answerName: "B", showingIndex: gameStateData.randomQuestionAnswerIndexes[1])
                                    }

                                    VStack(spacing: 40) {
                                        AnswerButton(answerName: "C", showingIndex: gameStateData.randomQuestionAnswerIndexes[2])
                                        AnswerButton(answerName: "D", showingIndex: gameStateData.randomQuestionAnswerIndexes[3])
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
                .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5667, saturation: 1.0000, brightness: 0.6176), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .animation(.easeInOut(duration: 0.2))
                .zIndex(0)
                
                VStack {
                    if gameStateData.coolDownTimerActive {
                        CooldownView()
                            .transition(.opacity)
                            .zIndex(1)
                    }
                }
                .animation(.easeInOut(duration: 1))
            }

            if gameStateData.showAudienceJokerData {
                HStack(alignment: .bottom, spacing: 20) {
                    ForEach(gameStateData.audienceJokerData.votingVariant, id: \.self) { pollSection in
                        VStack {
                            Text((numberFormatter.string(from: pollSection.probability) != nil) ? numberFormatter.string(from: pollSection.probability)! : "")
                                .foregroundColor(Color.white)

                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .bottom, endPoint: .top))
                                .frame(width: gameStateData.audienceJokerData.width, height: pollSection.height)

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
            let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, oldCurrentPrizeLevel: gameStateData.oldCurrentPrizeLevel)
            soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 961))
            .environmentObject(SoundManager())
            .environmentObject(MainViewController())
            .environmentObject(GameStateData())
    }
}
