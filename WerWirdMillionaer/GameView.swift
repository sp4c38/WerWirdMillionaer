//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

struct GameView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
    @State var jokerGuess: String = ""
    
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
            VStack {
                if prizesLoadedSuccessful {
                    HStack(spacing: 40) {
                        Button(action: {
                            soundManager.stopAllSounds()
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
                                            jokerGuess = ""
                                            
                                            gameStateData.timeOver = false
                                            gameStateData.timeKeepCounting = true
                                            gameStateData.timeRemaining = gameStateData.timeAllAvailable
                                            
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
                                            mainViewController.goToEndView()
                                        }
                                    }
                            }
                            
                            Text(prizesData.prizeLevels[gameStateData.currentPrizeLevel].name)
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
                            JokerButtonsView(jokerGuess: $jokerGuess, gameStateData: gameStateData)
                            
                            Spacer()
                            
                            TimeRemainingCircleView(gameStateData: gameStateData)
                            
                            Spacer()
                        }
                        
                        if jokerGuess != "" {
                            Text(jokerGuess)
                        }
                        
                        Spacer()
                        
                        VStack {    
                            QuestionTextView(question: gameStateData.randomQuestion.question)
                                .padding(.bottom, 20)
                            
                            HStack(spacing: 0) {
                                VStack(spacing: 40) {
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort A", showingIndex: 0, gameStateData: gameStateData)
                                    
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort B", showingIndex: 1, gameStateData: gameStateData)
                                }
                                
                                VStack(spacing: 40) {
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort C", showingIndex: 2, gameStateData: gameStateData)
                                
                                    AnswerButton(jokerGuess: $jokerGuess, answerName: "Antwort D", showingIndex: 3, gameStateData: gameStateData)
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
