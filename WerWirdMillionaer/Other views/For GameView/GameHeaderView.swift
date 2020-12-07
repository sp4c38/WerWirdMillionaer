//
//  TopHeaderView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 03.12.20.
//

import SwiftUI

struct GameHeaderView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
    var numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.currencySymbol = ""
        numberFormatter.maximumFractionDigits = 0
    }
    
    func getColor(foreground: Bool = false, background: Bool = false) -> Color {
        if (foreground == false && background == false) || (foreground == true && background == true) {
            return Color.white
        }
        
        var returnBackgroundColor: Color = Color.white
        
        if gameStateData.questionAnsweredCorrectly != nil {
            if gameStateData.questionAnsweredCorrectly == true {
                returnBackgroundColor = Color.green
            } else {
                returnBackgroundColor = Color.red
            }
        } else if gameStateData.answerSubmitted != nil {
            returnBackgroundColor = Color(red: 1, green: 0.62, blue: 0)
        } else {
            returnBackgroundColor = Color.white
        }
        
        if foreground {
            if returnBackgroundColor == Color.white {
                return Color.black
            } else {
                return Color.white
            }
        } else {
            return returnBackgroundColor
        }
    }
    
    var body: some View {
        HStack(spacing: 40) {
            Button(action: {
                soundManager.stopAllSounds()

                gameStateData.softStop = true
                mainViewController.changeViewShowIndex(newViewNumber: 3)
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
                            // Play the sound effect which indicates that the question was answered correctly
                            let soundEffectUrl = getQuestionAudioUrl(prizeLevel: gameStateData.currentPrizeLevel, isCorrect: true)
                            soundManager.playSoundEffect(soundUrl: soundEffectUrl)

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                                // Reset all data for next round
                                gameStateData.nextPrizeLevel()
                                gameStateData.updateRandomQuestion()
                                
                                let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, previousPrizeLevel: gameStateData.oldCurrentPrizeLevel)
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

                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                soundManager.stopAllSounds()

                                gameStateData.softStop = false
                                mainViewController.changeViewShowIndex(newViewNumber: 3)
                            }
                        }
                }

                Text("\(numberFormatter.string(from: NSNumber(value: prizesData.prizeLevels[gameStateData.currentPrizeLevel].amount))!) \(prizesData.unit)  Frage")
                    .font(.largeTitle)
                    .foregroundColor(getColor(foreground: true))

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(getColor(background: true))
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
        GameHeaderView()
    }
}
