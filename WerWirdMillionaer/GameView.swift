//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

struct GameView: View {
    @EnvironmentObject var mainViewController: MainViewController
    
    var prizesLoadedSuccessful: Bool = false
    
    init() {
        if questionData != nil {
            prizesLoadedSuccessful = true
        } else {
            prizesLoadedSuccessful = false
        }
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            VStack(spacing: 0) {
                if prizesLoadedSuccessful {
                    GameHeaderView() // Includes: end button, the prize money which can be won in the current round

                    Spacer()
                    Spacer()

                    GameCenterView() // Includes: Joker buttons, timer, prizes view
                        
                    Spacer()
                        
                    GameBottomView() // Includes: picture of the moderator, answer, answer options
                } else {
                    Text("Fragen konnten nicht geladen werden.")
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Image("MainBackground")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 15)
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.2))
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 961))
            .environmentObject(SoundManager())
            .environmentObject(MainViewController())
            .environmentObject(GameStateData())
    }
}
