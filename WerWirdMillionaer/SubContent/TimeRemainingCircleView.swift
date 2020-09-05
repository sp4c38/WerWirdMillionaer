//
//  TimeRemainingCircleView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 05.09.20.
//

import SwiftUI

struct TimeRemainingCircleView: View {
    @EnvironmentObject var soundManager: SoundManager
    
    var currentPrizesLevel: CurrentPrizesLevel
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timeNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            Text(String(currentPrizesLevel.timeRemaining))
                .bold()
                .font(.system(size: 120))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)

        }
        .padding(25)
        .background(
            Circle()
                .frame(width: 500)
        )
        .onReceive(timer) { _ in
            print("Timer run")
            if !(currentPrizesLevel.timeRemaining == 0 || currentPrizesLevel.timeRemaining < 0) && currentPrizesLevel.timeKeepCounting {
                currentPrizesLevel.timeRemaining = currentPrizesLevel.timeRemaining - 1
            } else {
                currentPrizesLevel.timeOver = true
                currentPrizesLevel.timeKeepCounting = false
            }
        }
    }
}
