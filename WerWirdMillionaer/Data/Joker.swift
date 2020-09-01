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
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    } else {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, currentPrizesLevel.randomQuestion.correct_answer)
    
    print("Telephone joker guessed \(guessedAnswer).")
    return guessedAnswer
}

func audienceJoker(currentPrizesLevel: CurrentPrizesLevel) -> String {
    let outputSelection: [String]
    
    if currentPrizesLevel.currentPrizeLevel == 0 || currentPrizesLevel.currentPrizeLevel == 1 || currentPrizesLevel.currentPrizeLevel == 2 {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    } else {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, currentPrizesLevel.randomQuestion.correct_answer)
    
    print("Telephone joker guessed \(guessedAnswer).")
    return guessedAnswer
}

func fifthfiftyJoker(currentPrizesLevel: CurrentPrizesLevel) {
    var selectionList = [currentPrizesLevel.randomQuestion.answer_a,
                         currentPrizesLevel.randomQuestion.answer_b,
                         currentPrizesLevel.randomQuestion.answer_c,
                         currentPrizesLevel.randomQuestion.answer_d]
    
    
    guard let correctAnswerFirstIndex = selectionList.firstIndex(of: currentPrizesLevel.randomQuestion.correct_answer) else {
        return
    }
    selectionList.remove(at: correctAnswerFirstIndex)
    
    let firstRandomElement = selectionList.randomElement()
    guard let firstRandomElementFirstIndex = selectionList.firstIndex(of: firstRandomElement!!) else {
        return
    }
    selectionList.remove(at: firstRandomElementFirstIndex)
    let secondRandomElement = selectionList.randomElement()
    
    if currentPrizesLevel.randomQuestion.answer_a == firstRandomElement || currentPrizesLevel.randomQuestion.answer_a == secondRandomElement {
        currentPrizesLevel.randomQuestion.answer_a = nil
    }
    if currentPrizesLevel.randomQuestion.answer_b == firstRandomElement || currentPrizesLevel.randomQuestion.answer_b == secondRandomElement {
        currentPrizesLevel.randomQuestion.answer_b = nil
    }
    if currentPrizesLevel.randomQuestion.answer_c == firstRandomElement || currentPrizesLevel.randomQuestion.answer_c == secondRandomElement {
        currentPrizesLevel.randomQuestion.answer_c = nil
    }
    if currentPrizesLevel.randomQuestion.answer_d == firstRandomElement || currentPrizesLevel.randomQuestion.answer_d == secondRandomElement {
        currentPrizesLevel.randomQuestion.answer_d = nil
    }
}

