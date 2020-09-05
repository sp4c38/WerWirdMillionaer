//
//  WerWirdMillionaerApp.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class SoundManager: NSObject, AVAudioPlayerDelegate, ObservableObject {
    var soundPlayers = [URL: AVAudioPlayer]()
    
    func playSound(soundUrl: URL?, loops: Int) {
        if let soundUrl = soundUrl {
            if let currentPlayer = soundPlayers[soundUrl] { // Player is already stored and not in use
                if !currentPlayer.isPlaying {
                    soundPlayers[soundUrl]!.prepareToPlay()
                    soundPlayers[soundUrl]!.play()
                } else { // Player is already stored but currently in use
                }
            } else {
                do {
                    let currentPlayer = try AVAudioPlayer(contentsOf: soundUrl)
                    soundPlayers[soundUrl] = currentPlayer
                    soundPlayers[soundUrl]!.prepareToPlay()
                    soundPlayers[soundUrl]!.play()
                } catch {
                    print("Couldn't play sound file at \(soundUrl). Exited with \(error)")
                }
            }
        }
    }
}

class SoundPlayer: ObservableObject {
    var player = AVAudioPlayer()
    
    func playSound(soundUrl: URL?, loops: Int) {
        if soundUrl != nil {
            do {
                print("Updated sound")
                self.player = try AVAudioPlayer(contentsOf: soundUrl!)
                player.numberOfLoops = loops
                player.play()
            } catch {
                print("Couldn't play audio sound.")
            }
        }
    }
}

@main
struct WerWirdMillionaerApp: App {
    var soundManager = SoundManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(soundManager)
        }
    }
}
