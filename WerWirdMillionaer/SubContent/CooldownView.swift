//
//  CooldownView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 22.09.20.
//

import SwiftUI

extension AnyTransition {
    static var inOutScale: AnyTransition {
        let insert = AnyTransition.scale(scale: 5).combined(with: .opacity)
        let removal = AnyTransition.scale(scale: 0.5).combined(with: .opacity)
        return .asymmetric(insertion: insert, removal: removal)
    }
}

struct CooldownView: View {
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
    @State var numberSwitch: Bool? = nil // Needed to display the transitions between the numbers correctly
    @State var counterSeconds = 3
    @State var switchedToNewSettings = false
    
    let timer = Timer.publish(every: 1.1, on: .main, in: .common).autoconnect()
    
    let numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
    }
    
    var body: some View {
        VStack {
            if numberSwitch != nil {
                if numberSwitch! {
                    Text(numberFormatter.string(from: NSNumber(value: counterSeconds))!)
                        .font(.system(size: 500, weight: .semibold, design: .rounded))
                        .transition(.inOutScale)
                } else if !(numberSwitch!) {
                    Text(numberFormatter.string(from: NSNumber(value: counterSeconds))!)
                        .font(.system(size: 500, weight: .semibold, design: .rounded))
                        .transition(.inOutScale)
                }
            }
        }
        .foregroundColor(Color.black)
        .shadow(color: Color.gray, radius: 10)
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
        .onAppear {
            if numberSwitch == nil {
                numberSwitch = false
            }
        }
        .onReceive(timer) { input in
            if !((counterSeconds) == 1) {
                withAnimation {
                    if numberSwitch != nil {
                        numberSwitch!.toggle()
                    }
                    
                    counterSeconds -= 1
                }
            } else {
                if !switchedToNewSettings {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        // Reset all data for next round
                        gameStateData.questionAnsweredCorrectly = nil

                        gameStateData.showAudienceJokerData = false
                        gameStateData.audienceJokerData = AudiencePollCollection()

                        gameStateData.timeRemaining = gameStateData.timeAllAvailable
                        gameStateData.timeOver = false
                        gameStateData.timeKeepCounting = true
                        gameStateData.coolDownTimerActive = false
                        
                        gameStateData.nextPrizeLevel()
                        gameStateData.updateRandomQuestion()
                        
                        
                        let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, oldCurrentPrizeLevel: gameStateData.oldCurrentPrizeLevel)
                        soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
                        
                        switchedToNewSettings.toggle()
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 1.05))
    }
}

struct CooldownView_Previews: PreviewProvider {
    static var previews: some View {
        CooldownView()
            .previewLayout(.fixed(width: 1500, height: 961))
    }
}
