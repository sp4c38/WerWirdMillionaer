//
//  GetQuestionAudioName.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 02.09.20.
//

import AVFoundation
import Foundation

func getJokerAudioUrl(prizeLevel: Int, isCorrect: Bool) -> URL? {
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
