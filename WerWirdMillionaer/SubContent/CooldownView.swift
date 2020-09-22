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
    @EnvironmentObject var gameStateData: GameStateData
    
    @State var numberSwitch: Bool? = nil // Needed to display the transitions between the numbers correctly
    @State var counterSeconds = 3
    @State var switchedToNewSettings = false
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
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
        .foregroundColor(Color.white)
        .shadow(color: Color.black, radius: 70)
        .padding(20)
        .onReceive(timer) { input in
            if !((counterSeconds) == 1) {
                withAnimation {
                    if numberSwitch != nil {
                        numberSwitch!.toggle()
                    } else {
                        numberSwitch = false
                        counterSeconds += 1 // Add one the first time to correctly display the seconds
                    }
                    
                    counterSeconds -= 1
                }
            } else {
                if !switchedToNewSettings {
                    gameStateData.timeOver = false
                    gameStateData.timeKeepCounting = true
                    gameStateData.coolDownTimerActive = false
                    switchedToNewSettings.toggle()
                }
            }
        }
        .animation(.easeInOut(duration: 0.7))
    }
}

struct CooldownView_Previews: PreviewProvider {
    static var previews: some View {
        CooldownView()
            .previewLayout(.fixed(width: 1500, height: 961))
    }
}
