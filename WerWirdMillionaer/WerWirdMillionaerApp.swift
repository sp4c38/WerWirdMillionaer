//
//  WerWirdMillionaerApp.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class GameStateData: ObservableObject {
    @Published var currentPrizeLevel: Int = 0
    @Published var oldCurrentPrizeLevel: Int = -1
    
    @Published var questionAnsweredCorrectly: Bool? = nil
    
    @Published var randomQuestion = Question(question: "", answerA: "", answerB: "", answerC: "", answerD: "", correctAnswer: "")
    
    @Published var timeAllAvailable = 30 // Time altogether avaliable to answer a question
    @Published var timeRemaining = 30 // Remaining time in seconds (must be same as timeAllAvailable)
    @Published var timeKeepCounting = true // Indicates if the timer counts
    @Published var timeOver = false // Set to true if the time is over
    
    @Published var telephoneJokerActive = true
    @Published var audienceJokerActive = true
    @Published var fiftyfiftyJokerActive = true
    @Published var showAudienceJokerData = false
    @Published var audienceJokerData = AudiencePollCollection()
    
    func nextPrizeLevel() {
        if currentPrizeLevel + 2 <= questionData!.prizeLevels.count {
            self.currentPrizeLevel += 1
            oldCurrentPrizeLevel += 1
        } else {
            print("Maximum prize level reached. Staying on \(currentPrizeLevel) prize level")
        }
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel].questions.randomElement()!
    }
}

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
    var mainViewController = MainViewController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(soundManager)
                .environmentObject(mainViewController)
        }
    }
}
