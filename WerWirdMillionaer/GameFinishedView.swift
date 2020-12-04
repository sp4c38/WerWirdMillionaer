//
//  GameEndedView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 13.09.20.
//

import SwiftUI

struct GameFinishedView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var gameStateData: GameStateData
    
    func findLastPrizeWithSecurityLevel() -> Int {
        for prizeLevel in prizesData.prizeLevels.reversed() {
            let prizeLevelIndex = prizesData.prizeLevels.lastIndex(of: prizeLevel)
            if prizeLevelIndex != nil {
                if prizeLevel.isSecurityLevel && prizeLevelIndex! < gameStateData.oldCurrentPrizeLevel {
                    return prizeLevelIndex!
                }
            }
        }
        
        return 0
    }
    
    var numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.currencySymbol = "€"
        numberFormatter.maximumFractionDigits = 0
    }
    
    var body: some View {
        let prize = prizesData.prizeLevels[gameStateData.oldCurrentPrizeLevel] // Use the last prize level as reference point because the last question was answered correctly
        
        VStack(spacing: 50) {
            Spacer()
            
            let lastPrizeWithSecurityLevel = findLastPrizeWithSecurityLevel()
            
            VStack {
                
                if (gameStateData.softStop == true && prize.amount == 0) {
                    Text("❌")
                } else {
                    if (gameStateData.softStop == false && prizesData.prizeLevels[lastPrizeWithSecurityLevel].amount == 0) {
                        Text("❌")
                    } else {
                        Text("🎉")
                    }
                }
            }
            .font(.system(size: 150))
            
            if gameStateData.softStop == true || prize.isSecurityLevel {
                Text("\(numberFormatter.string(from: NSNumber(value: prize.amount)) ?? "NaN") gewonnen!")
                    .underline()
                    .bold()
                    .foregroundColor(Color.white)
                    .font(.system(size: 100))
                    .shadow(radius: 20)
                
            } else { // Triggered when current prize level is no security level which means that last nearest security level is used
                Text("\(numberFormatter.string(from: NSNumber(value: prizesData.prizeLevels[lastPrizeWithSecurityLevel].amount)) ?? "NaN") gewonnen!")
                    .underline()
                    .bold()
                    .foregroundColor(Color.white)
                    .font(.system(size: 100))
                    .shadow(radius: 20)
            }
            
            Spacer()
            
            Text("Zurück zur Startseite")
                .font(.title)
                .foregroundColor(Color.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .onTapGesture {
                    gameStateData.resetForNextGame()
                    mainViewController.changeViewShowIndex(newViewNumber: 0)
                    gameStateData.updateRandomQuestion()
                }
        }
        .shadow(radius: 10)
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

struct GameEndedView_Previews: PreviewProvider {
    static var previews: some View {
        GameFinishedView()
            .previewLayout(.fixed(width: 1000, height: 661))
            .environmentObject(GameStateData())
    }
}
