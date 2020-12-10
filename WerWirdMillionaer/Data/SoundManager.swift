//
//  SoundManager.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 04.12.20.
//

import AVFoundation
import Foundation

class SoundManager: NSObject, ObservableObject {
    var soundEffectsPlayers = [URL: AVPlayer]()
    var backgroundMusicPlayer = AVQueuePlayer()
    var backgroundMusicLooper: AVPlayerLooper? = nil
    
    func playSoundEffect(soundUrl: URL?) {
        if let soundUrl = soundUrl {
            if let currentPlayer = soundEffectsPlayers[soundUrl] { // Player is already stored and not in use
                if currentPlayer.timeControlStatus == .paused {
                    currentPlayer.seek(to: CMTime(value: 0, timescale: 1))
                    currentPlayer.play()
                } else { // Player is already stored but currently in use
                }
            } else {
                let asset = AVAsset(url: soundUrl)
                let item = AVPlayerItem(asset: asset)
                let params = AVMutableAudioMixInputParameters(track: asset.tracks.first!)
                
                let firstSecondFraction = CMTimeRangeMake(start: CMTime(value: 0, timescale: 1), duration: CMTime(value: 1, timescale: 4))
                
                params.setVolumeRamp(fromStartVolume: 0, toEndVolume: 1, timeRange: firstSecondFraction)
                
                let mixer = AVMutableAudioMix()
                mixer.inputParameters = [params]
                item.audioMix = mixer
                
                let currentPlayer = AVPlayer(playerItem: item)
                soundEffectsPlayers[soundUrl] = currentPlayer
                soundEffectsPlayers[soundUrl]?.play()
            }
        }
    }
    
    func playBackgroundMusic(soundUrl: URL?, playInfinite: Bool = true) {
        if let soundUrl = soundUrl {
            let asset = AVAsset(url: soundUrl)
            let duration = CMTimeGetSeconds(asset.duration)
            let item = AVPlayerItem(asset: AVAsset(url: soundUrl))
            
            let params = AVMutableAudioMixInputParameters(track: asset.tracks.first!)
            
            let firstSecond = CMTimeRangeMake(start: CMTimeMake(value: 0, timescale: 1), duration: CMTimeMake(value: 1, timescale: 1))
            let lastSecond = CMTimeRangeMake(start: CMTimeMake(value: Int64(duration - 1), timescale: 1), duration: CMTimeMake(value: 1, timescale: 1))
            
            params.setVolumeRamp(fromStartVolume: 0, toEndVolume: 0.9, timeRange: firstSecond)
            params.setVolumeRamp(fromStartVolume: 0.9, toEndVolume: 0, timeRange: lastSecond)
            
            let mix = AVMutableAudioMix()
            
            mix.inputParameters = [params]
            item.audioMix = mix
            
            backgroundMusicPlayer = AVQueuePlayer(playerItem: item)
            if playInfinite {
                backgroundMusicLooper = AVPlayerLooper(player: backgroundMusicPlayer, templateItem: item)
            }

            backgroundMusicPlayer.play()
        }
    }
    
    func stopPlayingSoundEffect(for soundUrl: URL) {
        if soundEffectsPlayers[soundUrl] != nil {
            if soundEffectsPlayers[soundUrl]!.timeControlStatus == .playing {
                soundEffectsPlayers[soundUrl]!.pause()
            }
        }
    }
    
    func stopAllSounds() {
        if !backgroundMusicPlayer.items().isEmpty {
            backgroundMusicPlayer.pause()
        }
        
        for soundEffect in soundEffectsPlayers {
            if soundEffect.value.timeControlStatus == .playing {
                soundEffect.value.pause()
            }
        }
    }
}
