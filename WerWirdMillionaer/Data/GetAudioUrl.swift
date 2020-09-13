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
    
    if currentPrizesLevel <= 5 && (!(oldCurrentPrizeLevel <= 5) || oldCurrentPrizeLevel == 0) {
        audioFileUrl = Bundle.main.url(forResource: "50-500_intro_sound.mp3", withExtension: nil)
    } else if currentPrizesLevel > 5 && currentPrizesLevel <= 10  && !(oldCurrentPrizeLevel > 5) {
        audioFileUrl = Bundle.main.url(forResource: "1000-16000_intro_sound.mp3", withExtension: nil)
    } else if currentPrizesLevel > 10 && currentPrizesLevel <= 14 && !(oldCurrentPrizeLevel > 10) {
        audioFileUrl = Bundle.main.url(forResource: "32000-5000000_intro_sound.mp3", withExtension: nil)
    } else if currentPrizesLevel == 15 && !(oldCurrentPrizeLevel == 15) {
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
    
    if prizeLevel <= 5 { // 0-, 50-, 100-, 200-, 300- and 500-Questions / 0-indexed
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "50-500_answer_correct.mp3", withExtension: nil)
        } else {
            audioFileUrl = Bundle.main.url(forResource: "50-500_answer_wrong.mp3", withExtension: nil)
        }
    } else if prizeLevel > 5 && prizeLevel <= 10 {
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "1000-16000_answer_correct.mp3", withExtension: nil)
        } else {
            audioFileUrl = Bundle.main.url(forResource: "1000-16000_answer_wrong.mp3", withExtension: nil)
        }
    } else if prizeLevel > 10 && prizeLevel <= 14 {
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "32000-500000_answer_correct.mp3", withExtension: nil)
        } else {
            audioFileUrl = Bundle.main.url(forResource: "32000-500000_answer_wrong.mp3", withExtension: nil)
        }
    } else if prizeLevel == 15 {
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "1000000_answer_correct.mp3", withExtension: nil)
        } else {
            audioFileUrl = Bundle.main.url(forResource: "1000000_answer_wrong.mp3", withExtension: nil)
        }
    }
    
    if audioFileUrl == nil {
        print("Audio file wasn't found.")
        return nil
    }
    
    return audioFileUrl
}
