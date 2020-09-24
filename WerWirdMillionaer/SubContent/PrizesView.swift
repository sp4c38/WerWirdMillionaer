//
//  PrizesView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 24.09.20.
//

import SwiftUI

struct PrizesView: View {
    @EnvironmentObject var gameStateData: GameStateData
    
    var numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.currencySymbol = ""
        numberFormatter.maximumFractionDigits = 0
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .center, spacing: 3.3) {
                ForEach(-(prizesData.prizeLevels.count - 1)..<0) { index in
                    let indexIsSecurityLevel = prizesData.prizeLevels[abs(index)].isSecurityLevel
                    
                    Text(String(abs(index)))
                        .font(.title2)
                        .bold()
                        .foregroundColor(indexIsSecurityLevel ? Color.white : Color(hue: 0.0665, saturation: 0.7910, brightness: 0.9569))
                }
            }
            
            VStack(alignment: .center, spacing: 3.3) {
                ForEach(-(prizesData.prizeLevels.count - 1)..<0) { index in
                    Text("-")
                        .foregroundColor(Color.white)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.white)
                }
            }
            
            VStack(alignment: .trailing, spacing: 3.3) {
                ForEach(prizesData.prizeLevels.reversed(), id: \.amount) { level in
                    let firstPrizeLevelIndex = prizesData.prizeLevels.firstIndex(of: level)
                    
                    if firstPrizeLevelIndex != 0 {
                        HStack {
                            Spacer()
                            
                            Text(numberFormatter.string(from: NSNumber(value: level.amount))!)
                                .font(.title2)
                                .bold()
                                .cornerRadius(3)
                            
                            Text(prizesData.unit)
                                .font(.title2)
                                .bold()
                        }
                        .foregroundColor((gameStateData.currentPrizeLevel == firstPrizeLevelIndex!) ? Color.white : (level.isSecurityLevel ? Color.white : Color(hue: 0.0665, saturation: 0.7910, brightness: 0.9569)))
                        .padding(.trailing, 10)
                        .background((gameStateData.currentPrizeLevel == firstPrizeLevelIndex!) ? Color(hue: 0.0665, saturation: 0.7910, brightness: 0.9569) : Color.white.opacity(0))
                        .shadow(color: (gameStateData.currentPrizeLevel == firstPrizeLevelIndex!) ? Color.black : Color.black, radius: 5)
                        .cornerRadius(5)
                        .padding(.leading, 5)
                    }
                }
            }
        }
        .shadow(color: Color.white, radius: 20)
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 3))
        .background(
            Image("PrizesViewBackgroundImage")
                .resizable()
                .scaledToFill()
                .blur(radius: 10)
            
        )
        .cornerRadius(10)
        .frame(width: 240)
    }
}

struct PrizesView_Previews: PreviewProvider {
    static var previews: some View {
        PrizesView()
            .previewLayout(.fixed(width: 1500, height: 961))
            .environmentObject(GameStateData())
    }
}
