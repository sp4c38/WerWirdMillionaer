//
//  JokerButtonsView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import AVFoundation
import SwiftUI

struct JokerButtonsView: View {
    @EnvironmentObject var soundManager: SoundManager
    
    @Binding var jokerGuess: String
    var currentPrizesLevel: CurrentPrizesLevel
    let speech = AVSpeechSynthesizer()
    
    var body: some View {
        VStack {
            ZStack {
                Button (action: {
                    if currentPrizesLevel.fiftyfiftyJokerActive {
                        fifthfiftyJoker(currentPrizesLevel: currentPrizesLevel)
                        currentPrizesLevel.fiftyfiftyJokerActive = false
                        let soundUrl = getJokerAudioUrl(jokerName: "50-50")
                        soundManager.playSound(soundUrl: soundUrl, loops: 0)
                    }
                }) {
                    ZStack {
                        Image("50-50")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        if !currentPrizesLevel.fiftyfiftyJokerActive {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.red)
                        }
                    }
                }.disabled(currentPrizesLevel.fiftyfiftyJokerActive ? false : true )
            }
            
            ZStack {
                Button (action: {
                    if currentPrizesLevel.audienceJokerActive {
                        currentPrizesLevel.audienceJokerData =  audienceJoker(currentPrizesLevel: currentPrizesLevel)
                        currentPrizesLevel.audienceJokerActive = false
                        currentPrizesLevel.showAudienceJokerData = true
                        let soundUrl = getJokerAudioUrl(jokerName: "audience")
                        soundManager.playSound(soundUrl: soundUrl, loops: 0)
                    }
                }) {
                    ZStack {
                        Image("audience")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        if !currentPrizesLevel.audienceJokerActive {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.red)
                        }
                    }
                }.disabled(currentPrizesLevel.audienceJokerActive ? false : true )
            }
            
            ZStack {
                Button (action: {
                    if currentPrizesLevel.telephoneJokerActive {
                        jokerGuess = telephoneJoker(currentPrizesLevel: currentPrizesLevel)
                        let utterance = AVSpeechUtterance(string: jokerGuess)
                        utterance.voice = AVSpeechSynthesisVoice(language: "German")
                        utterance.volume = 1.0
                        utterance.pitchMultiplier = Float.random(in: 0.3..<2)
                        speech.speak(utterance)
                        currentPrizesLevel.telephoneJokerActive = false
                    }
                }) {
                    ZStack {
                        Image("telephone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        if !currentPrizesLevel.telephoneJokerActive {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.red)
                        }
                    }
                }.disabled(currentPrizesLevel.telephoneJokerActive ? false : true )
            }
        }
    }
}
