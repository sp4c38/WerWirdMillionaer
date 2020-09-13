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
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            
            Text("🎉")
                .font(.system(size: 150))
            
            Text("\(prizesData.prizeLevels[gameStateData.currentPrizeLevel].name) Gewonnen!")
                .underline()
                .bold()
                .foregroundColor(Color.white)
                .font(.system(size: 100))
                .shadow(radius: 20)
            
            Spacer()
            
            Text("Zurück zur Startseite")
                .font(.title)
                .foregroundColor(Color.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .onTapGesture {
                    mainViewController.goBackToStartView()
                }
        }
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
