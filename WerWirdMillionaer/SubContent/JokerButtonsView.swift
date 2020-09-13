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
    var gameStateData: GameStateData
    let speech = AVSpeechSynthesizer()
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Button (action: {
                    if gameStateData.fiftyfiftyJokerActive {
                        fifthfiftyJoker(gameStateData: gameStateData)
                        gameStateData.fiftyfiftyJokerActive = false
                        let soundUrl = getJokerAudioUrl(jokerName: "50-50")
                        soundManager.playSoundEffect(soundUrl: soundUrl)
                    }
                }) {
                    ZStack {
                        Image("50-50")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        if !gameStateData.fiftyfiftyJokerActive {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.red)
                        }
                    }
                }.disabled(gameStateData.fiftyfiftyJokerActive ? false : true )
            }
            
            ZStack {
                Button (action: {
                    if gameStateData.audienceJokerActive {
                        gameStateData.audienceJokerData =  audienceJoker(gameStateData: gameStateData)
                        gameStateData.audienceJokerActive = false
                        gameStateData.showAudienceJokerData = true
                        let soundUrl = getJokerAudioUrl(jokerName: "audience")
                        soundManager.playSoundEffect(soundUrl: soundUrl)
                    }
                }) {
                    ZStack {
                        Image("audience")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        if !gameStateData.audienceJokerActive {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.red)
                        }
                    }
                }.disabled(gameStateData.audienceJokerActive ? false : true )
            }
            
            ZStack {
                Button (action: {
                    if gameStateData.telephoneJokerActive {
                        jokerGuess = telephoneJoker(gameStateData: gameStateData)
                        let utterance = AVSpeechUtterance(string: jokerGuess)
                        utterance.voice = AVSpeechSynthesisVoice(language: "German")
                        utterance.volume = 1.0
                        utterance.pitchMultiplier = Float.random(in: 0.3..<2)
                        speech.speak(utterance)
                        gameStateData.telephoneJokerActive = false
                    }
                }) {
                    ZStack {
                        Image("telephone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        if !gameStateData.telephoneJokerActive {
                            Image(systemName: "multiply")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.red)
                        }
                    }
                }.disabled(gameStateData.telephoneJokerActive ? false : true )
            }
        }
    }
}
