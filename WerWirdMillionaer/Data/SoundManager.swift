//
//  SoundManager.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 04.12.20.
//

import AVFoundation
import Foundation

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
    
    func playBackgroundMusic(soundUrl: URL?, playInfinite: Bool = true) {
        if let soundUrl = soundUrl {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: soundUrl)
                if playInfinite {
                    backgroundMusicPlayer.numberOfLoops = -1
                } else {
                    backgroundMusicPlayer.numberOfLoops = 0
                }
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
