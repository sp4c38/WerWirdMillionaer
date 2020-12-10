//
//  GetQuestionAudioName.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 02.09.20.
//

import AVFoundation
import Foundation

func getGeneralMusicAudioUrl(intro: Bool = false, outro: Bool = false, gameWon: Bool = false) -> URL? {
    if intro {
        return Bundle.main.url(forResource: "general_intro_sound", withExtension: "mp3")
    } else if outro {
        return Bundle.main.url(forResource: "outro_sound", withExtension: "mp3")
    } else if gameWon {
        return Bundle.main.url(forResource: "game_won_sound", withExtension: "mp3")
    }
    else {
        return nil
    }
}

func getBackgroundAudioUrl(currentPrizesLevel: Int, previousPrizeLevel: Int) -> URL? {
    // The previous prize level is needed to check if the music is still the same with the current prize level compared to the previous prize level. If so the music already playing can play further and doesn't need to start new.
    
    var audioFileUrl: URL? = nil
    
    if currentPrizesLevel <= 5 && (!(previousPrizeLevel <= 5) || previousPrizeLevel == 0) {
        audioFileUrl = Bundle.main.url(forResource: "50-500_intro_sound", withExtension: "mp3")
    } else if currentPrizesLevel > 5 && currentPrizesLevel <= 10  && !(previousPrizeLevel > 5) {
        audioFileUrl = Bundle.main.url(forResource: "1000-16000_intro_sound", withExtension: "mp3")
    } else if currentPrizesLevel > 10 && currentPrizesLevel <= 14 && !(previousPrizeLevel > 10) {
        audioFileUrl = Bundle.main.url(forResource: "32000-5000000_intro_sound", withExtension: "mp3")
    } else if currentPrizesLevel == 15 && !(previousPrizeLevel == 15) {
        audioFileUrl = Bundle.main.url(forResource: "1000000_intro_sound", withExtension: "mp3")
    } else {
        audioFileUrl = nil
    }
    
    return audioFileUrl
}

func getJokerAudioUrl(jokerName: String) -> URL? {
    var audioFileUrl: URL? = nil
    
    if jokerName == "50-50" { // 50:50 joker
        audioFileUrl = Bundle.main.url(forResource: "50-50_joker_sound", withExtension: "mp3")
    } else if jokerName == "audience" {
        audioFileUrl = Bundle.main.url(forResource: "audience_joker_sound", withExtension: "mp3")
    } else if jokerName == "telephone" {
        audioFileUrl = Bundle.main.url(forResource: "telephone_joker_sound", withExtension: "mp3")
    }
    
    if audioFileUrl == nil {
        print("Audio file wasn't found.")
        return nil
    }
    
    return audioFileUrl
}

func getAnswerSubmittedUrl() -> URL? {
    return Bundle.main.url(forResource: "submit_answer_sound", withExtension: "mp3")
}

func getQuestionAudioUrl(prizeLevel: Int, isCorrect: Bool) -> URL? {
    var audioFileUrl: URL? = nil
    
    if prizeLevel <= 5 { // 0-, 50-, 100-, 200-, 300- and 500-Questions / 0-indexed
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "50-500_answer_correct", withExtension: "mp3")
        } else {
            audioFileUrl = Bundle.main.url(forResource: "50-500_answer_wrong", withExtension: "mp3")
        }
    } else if prizeLevel > 5 && prizeLevel <= 10 {
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "1000-16000_answer_correct", withExtension: "mp3")
        } else {
            audioFileUrl = Bundle.main.url(forResource: "1000-16000_answer_wrong", withExtension: "mp3")
        }
    } else if prizeLevel > 10 && prizeLevel <= 14 {
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "32000-500000_answer_correct", withExtension: "mp3")
        } else {
            audioFileUrl = Bundle.main.url(forResource: "32000-500000_answer_wrong", withExtension: "mp3")
        }
    } else if prizeLevel == 15 {
        if isCorrect {
            audioFileUrl = Bundle.main.url(forResource: "1000000_answer_correct", withExtension: "mp3")
        } else {
            audioFileUrl = Bundle.main.url(forResource: "1000000_answer_wrong", withExtension: "mp3")
        }
    }
    
    if audioFileUrl == nil {
        print("Audio file wasn't found.")
        return nil
    }
    
    return audioFileUrl
}
