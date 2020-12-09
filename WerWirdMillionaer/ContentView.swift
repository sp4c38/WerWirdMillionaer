//
//  ContentView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class MainViewController: ObservableObject {
    @Published var viewShowIndex = 1
    
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
                GameIntroVideoView()
                    .environmentObject(gameStateData)
                    .transition(.opacity)
                    .zIndex(0)
            } else if mainViewController.viewShowIndex == 1 {
                HomeView()
                    .environmentObject(gameStateData)
                    .transition(.opacity)
                    .zIndex(1)
            } else if mainViewController.viewShowIndex == 2 {
                GameView()
                    .environmentObject(gameStateData)
                    .transition(.opacity)
                    .zIndex(2)
            } else if mainViewController.viewShowIndex == 3 {
                GameFinishedView()
                    .environmentObject(gameStateData)
                    .transition(.opacity)
                    .zIndex(3)
            }
        }
        .onChange(of: mainViewController.viewShowIndex) { newValue in
            if newValue == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    gameStateData.resetForNextGame()
                    gameStateData.updateRandomQuestion()
                }
            }
        }
        .animation(.easeInOut(duration: 0.6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
