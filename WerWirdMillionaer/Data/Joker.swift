//
//  Joker.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import SwiftUI
import Foundation

func telephoneJoker(currentPrizesLevel: CurrentPrizesLevel) -> String {
    let outputSelection: [String]
    
    if currentPrizesLevel.currentPrizeLevel == 0 || currentPrizesLevel.currentPrizeLevel == 1 || currentPrizesLevel.currentPrizeLevel == 2 {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    } else {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, currentPrizesLevel.randomQuestion.correctAnswer)
    
    print("Telephone joker guessed \(guessedAnswer).")
    return guessedAnswer
}

struct VotingVariant: Hashable {
    let name: String
    let height: CGFloat
    let probability: NSNumber
    
    init(name: String, height: CGFloat, probability: NSNumber) {
        self.name = name
        self.height = height
        self.probability = probability
    }
}

class AudiencePollCollection {
    let maximalHeight: CGFloat = 200
    let minHeight: CGFloat = 10
    let width: CGFloat = 50
    
    var votingVariant = [VotingVariant(name: "", height: 0, probability: 0), VotingVariant(name: "", height: 0, probability: 0), VotingVariant(name: "", height: 0, probability: 0), VotingVariant(name: "", height: 0, probability: 0)]
}

func audienceJoker(currentPrizesLevel: CurrentPrizesLevel) -> AudiencePollCollection {
    let audiencePollCollection = AudiencePollCollection()
    let probability: CGFloat

    if currentPrizesLevel.currentPrizeLevel < 2 {
        probability = 1
    } else {
        probability = 0.5
    }

    var currentIndex = 0
    for variant in [currentPrizesLevel.randomQuestion.answerA,
                    currentPrizesLevel.randomQuestion.answerB,
                    currentPrizesLevel.randomQuestion.answerC,
                    currentPrizesLevel.randomQuestion.answerD] {
        
        let name: String = ((currentIndex == 0) ? "A" : ((currentIndex == 1) ? "B" : ((currentIndex == 2) ? "C" : ((currentIndex == 3) ? "D" : ""))))
        let isCorrect = (currentPrizesLevel.randomQuestion.correctAnswer == variant)
        
        audiencePollCollection.votingVariant[currentIndex] =
            VotingVariant(
                name: name,
                height: CGFloat(
                    (isCorrect ? (audiencePollCollection.maximalHeight * probability) :
                        audiencePollCollection.minHeight)
                ),
                probability: (isCorrect ? NSNumber(value: Float(probability)) : 0)
            )
        
        currentIndex += 1
    }
    
    return audiencePollCollection
}

func fifthfiftyJoker(currentPrizesLevel: CurrentPrizesLevel) {
    var selectionList = [currentPrizesLevel.randomQuestion.answerA,
                         currentPrizesLevel.randomQuestion.answerB,
                         currentPrizesLevel.randomQuestion.answerC,
                         currentPrizesLevel.randomQuestion.answerD]
    
    
    guard let correctAnswerFirstIndex = selectionList.firstIndex(of: currentPrizesLevel.randomQuestion.correctAnswer) else {
        return
    }
    selectionList.remove(at: correctAnswerFirstIndex)
    
    let firstRandomElement = selectionList.randomElement()
    guard let firstRandomElementFirstIndex = selectionList.firstIndex(of: firstRandomElement!!) else {
        return
    }
    selectionList.remove(at: firstRandomElementFirstIndex)
    let secondRandomElement = selectionList.randomElement()
    
    if currentPrizesLevel.randomQuestion.answerA == firstRandomElement || currentPrizesLevel.randomQuestion.answerA == secondRandomElement {
        currentPrizesLevel.randomQuestion.answerA = nil
    }
    if currentPrizesLevel.randomQuestion.answerB == firstRandomElement || currentPrizesLevel.randomQuestion.answerB == secondRandomElement {
        currentPrizesLevel.randomQuestion.answerB = nil
    }
    if currentPrizesLevel.randomQuestion.answerC == firstRandomElement || currentPrizesLevel.randomQuestion.answerC == secondRandomElement {
        currentPrizesLevel.randomQuestion.answerC = nil
    }
    if currentPrizesLevel.randomQuestion.answerD == firstRandomElement || currentPrizesLevel.randomQuestion.answerD == secondRandomElement {
        currentPrizesLevel.randomQuestion.answerD = nil
    }
}

