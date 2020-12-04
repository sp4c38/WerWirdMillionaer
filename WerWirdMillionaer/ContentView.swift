//
//  ContentView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class MainViewController: ObservableObject {
    @Published var viewShowIndex = 0
    
    func changeViewShowIndex(newViewNumber: Int) {
        viewShowIndex = newViewNumber
    }
}

struct ContentView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    
    var gameStateData = GameStateData()
    
    init() {
        gameStateData.updateRandomQuestion()
    }
    
    var body: some View {
        VStack {
            if mainViewController.viewShowIndex == 0 {
                HomeView()
                    .transition(.opacity)
            } else if mainViewController.viewShowIndex == 1 {
                GameIntroVideoView()
                    .transition(.opacity)
            } else if mainViewController.viewShowIndex == 2 {
                GameView()
                    .transition(.opacity)
                    .environmentObject(gameStateData)

            } else if mainViewController.viewShowIndex == 3 {
                GameFinishedView()
                    .transition(.opacity)
                    .environmentObject(gameStateData)
            }
        }.animation(.easeInOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
