//
//  GetQuestionAudioName.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 02.09.20.
//

import AVFoundation
import Foundation

func getBackgroundAudioUrl(currentPrizesLevel: Int, oldCurrentPrizeLevel: Int) -> URL? {
    var audioFileUrl: URL? = nil
    
    print(oldCurrentPrizeLevel)
    print(currentPrizesLevel)
    if currentPrizesLevel <= 3 && (!(oldCurrentPrizeLevel <= 3) || oldCurrentPrizeLevel == -1) {
        audioFileUrl = Bundle.main.url(forResource: "50-500_intro_sound.mp3", withExtension: nil)
    } else if currentPrizesLevel > 3 && currentPrizesLevel <= 9  && !(oldCurrentPrizeLevel > 3) {
        audioFileUrl = Bundle.main.url(forResource: "1000-16000_intro_sound.mp3", withExtension: nil)
    } else if currentPrizesLevel == 14 && !(oldCurrentPrizeLevel == 14) {
        audioFileUrl = Bundle.main.url(forResource: "1000000_intro_sound.mp3", withExtension: nil)
    } else {
        audioFileUrl = nil
    }
    
    return audioFileUrl
}

func getJokerAudioUrl(jokerName: String) -> URL? {
    var audioFileUrl: URL? = nil
    
    if jokerName == "50-50" { // 50:50 joker
        audioFileUrl = Bundle.main.url(forResource: "50-50_joker_sound.mp3", withExtension: nil)
    } else if jokerName == "audience" {
        audioFileUrl = Bundle.main.url(forResource: "audience_joker_sound.mp3", withExtension: nil)
    } else if jokerName == "telephone" {
        audioFileUrl = Bundle.main.url(forResource: "telephone_joker_sound.mp3", withExtension: nil)
    }
    
    if audioFileUrl == nil {
        print("Audio file wasn't found.")
        return nil
    }
    
    return audioFileUrl
}

func getQuestionAudioUrl(prizeLevel: Int, isCorrect: Bool) -> URL? {
    var audioFileUrl: URL? = nil
    
    if prizeLevel <= 4 { // 50-, 100-, 200-, 300- and 500-Questions / 0-indexed
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "50-500_answer_correct.mp3", withExtension: nil)
        } else {
            audioFileUrl = Bundle.main.url(forResource: "50-500_answer_wrong.mp3", withExtension: nil)
        }
    }
    
    if audioFileUrl == nil {
        print("Audio file wasn't found.")
        return nil
    }
    
    return audioFileUrl
}
