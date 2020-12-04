//
//  GameCenterView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 04.12.20.
//

import SwiftUI

struct GameCenterView: View {
    @EnvironmentObject var gameStateData: GameStateData
    
    var body: some View {
        HStack {
            JokerButtonsView()

            if gameStateData.audienceJokerData != nil {
                Spacer()
                AudienceJokerResultView()
                Spacer()
            }
            
            if gameStateData.telephoneJokerText != nil {
                Spacer()
                Text(gameStateData.telephoneJokerText!)
                    .foregroundColor(Color.black)
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 20)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 4))
                Spacer()
            }
            
            if gameStateData.telephoneJokerText == nil && gameStateData.audienceJokerData == nil {
                Spacer()
                Spacer()
                Spacer()
            }
            
            TimeRemainingCircleView()

            if gameStateData.telephoneJokerText == nil || gameStateData.audienceJokerData == nil {
                Spacer()
                Spacer()
            } else {
                Spacer()
            }
            
            PrizesView()
        }
        .padding(.leading, 40)
        .padding(.trailing, 40)
    }
}

struct GameCenterView_Previews: PreviewProvider {
    static var previews: some View {
        GameCenterView()
    }
}
