//
//  WerWirdMillionaerApp.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class SoundManager: NSObject, AVAudioPlayerDelegate, ObservableObject {
    var soundEffectsPlayers = [URL: AVAudioPlayer]()
    var backgroundMusicPlayer = AVAudioPlayer()
    
    func playSoundEffect(soundUrl: URL?) {
        if let soundUrl = soundUrl {
            if let currentPlayer = soundEffectsPlayers[soundUrl] { // Player is already stored and not in use
                if !currentPlayer.isPlaying {
                    soundEffectsPlayers[soundUrl]!.prepareToPlay()
                    soundEffectsPlayers[soundUrl]!.play()
                } else { // Player is already stored but currently in use
                }
            } else {
                do {
                    let currentPlayer = try AVAudioPlayer(contentsOf: soundUrl)
                    soundEffectsPlayers[soundUrl] = currentPlayer
                    soundEffectsPlayers[soundUrl]!.prepareToPlay()
                    soundEffectsPlayers[soundUrl]!.play()
                } catch {
                    print("Couldn't play sound file at \(soundUrl). Exited with \(error)")
                }
            }
        }
    }
    
    func playBackgroundMusic(soundUrl: URL?) {
        if let soundUrl = soundUrl {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: soundUrl)
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
            } catch {
                print("Couldn't play sound file at \(soundUrl). Exited with \(error)")
            }
        }
    }
    
    func stopAllSounds() {
        if backgroundMusicPlayer.isPlaying {
            backgroundMusicPlayer.stop()
        }
        
        for soundEffect in soundEffectsPlayers {
            if soundEffect.value.isPlaying {
                soundEffect.value.stop()
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
