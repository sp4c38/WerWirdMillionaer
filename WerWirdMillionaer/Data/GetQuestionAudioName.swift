//
//  GetQuestionAudioName.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 02.09.20.
//

import AVFoundation
import Foundation

func getQuestionAudioName(prizeLevel: Int, isCorrect: Bool) -> URL {
    let returnPlayer: URL
    
    if prizeLevel <= 4 { // 50-, 100-, 200-, 300- and 500-Questions / 0-indexed
        returnPlayer = Bundle.main.url(forResource: "", withExtension: <#T##String?#>)
    }
    
    return returnPlayer
}
