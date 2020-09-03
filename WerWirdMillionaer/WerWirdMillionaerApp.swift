//
//  WerWirdMillionaerApp.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class SoundPlayer: ObservableObject {
    var player = AVAudioPlayer()
    
    func playSound(soundUrl: URL?) {
        if soundUrl != nil {
            do {
                self.player = try AVAudioPlayer(contentsOf: soundUrl!)
                player.play()
            } catch {
                print("Couldn't play audio sound.")
            }
        }
    }
}

@main
struct WerWirdMillionaerApp: App {
    var soundPlayer = SoundPlayer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(soundPlayer)
        }
    }
}
