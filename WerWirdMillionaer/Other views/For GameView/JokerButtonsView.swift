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
    @EnvironmentObject var gameStateData: GameStateData
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Button (action: {
                    if gameStateData.fiftyfiftyJokerActive {
                        fiftyfiftyJoker(gameStateData: gameStateData)
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
                        gameStateData.audienceJokerData = audienceJoker(gameStateData: gameStateData)
                        gameStateData.audienceJokerActive = false
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
                        telephoneJoker(gameStateData: gameStateData)
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
