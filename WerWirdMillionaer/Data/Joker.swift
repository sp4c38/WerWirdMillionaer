//
//  Joker.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import Foundation

func telephoneJoker(currentPrizesLevel: CurrentPrizesLevel) -> String {
    let outputSelection: [String]
    
    if currentPrizesLevel.currentPrizeLevel == 0 || currentPrizesLevel.currentPrizeLevel == 1 || currentPrizesLevel.currentPrizeLevel == 2 {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm da \"%@\". Da bin ich mir sicher!", "Ja... okay. Da ist \"%@\" auf jedenfall richtig!"]
    } else {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm da \"%@\". Da bin ich mir sicher!", "Ja... okay. Da ist \"%@\" auf jedenfall richtig!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, currentPrizesLevel.randomQuestion.correct_answer)
    
    print("Telephone joker guessed \(guessedAnswer).")
    return guessedAnswer
}

func audienceJoker(currentPrizesLevel: CurrentPrizesLevel) -> String {
    let outputSelection: [String]
    
    if currentPrizesLevel.currentPrizeLevel == 0 || currentPrizesLevel.currentPrizeLevel == 1 || currentPrizesLevel.currentPrizeLevel == 2 {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm da \"%@\". Da bin ich mir sicher!", "Ja... okay. Da ist \"%@\" auf jedenfall richtig!"]
    } else {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm da \"%@\". Da bin ich mir sicher!", "Ja... okay. Da ist \"%@\" auf jedenfall richtig!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, currentPrizesLevel.randomQuestion.correct_answer)
    
    print("Telephone joker guessed \(guessedAnswer).")
    return guessedAnswer
}
