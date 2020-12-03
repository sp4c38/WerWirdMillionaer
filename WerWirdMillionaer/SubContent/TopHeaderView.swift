//
//  TopHeaderView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 03.12.20.
//

import SwiftUI

struct TopHeaderView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
    var prizeLevelNumberFormatter: NumberFormatter
    
    init() {
        prizeLevelNumberFormatter = NumberFormatter()
        prizeLevelNumberFormatter.numberStyle = .none
    }
    
    func getBackgroundColor() -> Color {
        if gameStateData.questionAnsweredCorrectly != nil {
            if gameStateData.questionAnsweredCorrectly == true {
                return Color.green
            } else {
                return Color.red
            }
        } else {
            return Color.white
        }
    }
    
    var body: some View {
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

                                gameStateData.telephoneJokerText = nil
                                gameStateData.audienceJokerData = nil

                                gameStateData.timeRemaining = gameStateData.timeAllAvailable
                                
                                gameStateData.nextPrizeLevel()
                                gameStateData.updateRandomQuestion()
                                
                                let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, oldCurrentPrizeLevel: gameStateData.oldCurrentPrizeLevel)
                                soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    gameStateData.timeOver = false
                                    gameStateData.timeKeepCounting = true
                                }
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

                Text("\(prizeLevelNumberFormatter.string(from: NSNumber(value: prizesData.prizeLevels[gameStateData.currentPrizeLevel].amount))!) \(prizesData.unit)  Frage")
                    .font(.largeTitle)
                    .foregroundColor((gameStateData.questionAnsweredCorrectly != nil) ? Color.white : Color.black)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(getBackgroundColor())
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .padding(.top, 40)
        .padding(.leading, 40)
        .padding(.trailing, 40)
        .padding(.bottom, 30)
    }
}

struct TopHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeaderView()
    }
}
