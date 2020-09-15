//
//  Joker.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import AVFoundation
import SwiftUI
import Foundation

func telephoneJoker(gameStateData: GameStateData) {
    let outputSelection: [String]
    
    if gameStateData.currentPrizeLevel == 0 || gameStateData.currentPrizeLevel == 1 || gameStateData.currentPrizeLevel == 2 {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    } else {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, gameStateData.randomQuestion.correctAnswer)
    
    print("Telephone joker guessed \(guessedAnswer).")
    
    let utterance = AVSpeechUtterance(string: guessedAnswer)
    utterance.voice = AVSpeechSynthesisVoice(language: "German")
    utterance.volume = 1.0
    utterance.pitchMultiplier = Float.random(in: 0.3..<2)
    let speech = AVSpeechSynthesizer()
    speech.speak(utterance)
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

func audienceJoker(gameStateData: GameStateData) -> AudiencePollCollection {
    let audiencePollCollection = AudiencePollCollection()
    let probability: CGFloat

    if gameStateData.currentPrizeLevel < 2 {
        probability = 1
    } else {
        probability = 0.5
    }

    var currentIndex = 0
    for variant in [gameStateData.randomQuestion.answerA,
                    gameStateData.randomQuestion.answerB,
                    gameStateData.randomQuestion.answerC,
                    gameStateData.randomQuestion.answerD] {
        
        let name: String = ((currentIndex == 0) ? "A" : ((currentIndex == 1) ? "B" : ((currentIndex == 2) ? "C" : ((currentIndex == 3) ? "D" : ""))))
        let isCorrect = (gameStateData.randomQuestion.correctAnswer == variant)
        
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

func fifthfiftyJoker(gameStateData: GameStateData) {
    var selectionList = [gameStateData.randomQuestion.answerA,
                         gameStateData.randomQuestion.answerB,
                         gameStateData.randomQuestion.answerC,
                         gameStateData.randomQuestion.answerD]
    
    
    guard let correctAnswerFirstIndex = selectionList.firstIndex(of: gameStateData.randomQuestion.correctAnswer) else {
        return
    }
    selectionList.remove(at: correctAnswerFirstIndex)
    
    let firstRandomElement = selectionList.randomElement()
    guard let firstRandomElementFirstIndex = selectionList.firstIndex(of: firstRandomElement!!) else {
        return
    }
    selectionList.remove(at: firstRandomElementFirstIndex)
    let secondRandomElement = selectionList.randomElement()
    
    if gameStateData.randomQuestion.answerA == firstRandomElement || gameStateData.randomQuestion.answerA == secondRandomElement {
        gameStateData.randomQuestion.answerA = nil
    }
    if gameStateData.randomQuestion.answerB == firstRandomElement || gameStateData.randomQuestion.answerB == secondRandomElement {
        gameStateData.randomQuestion.answerB = nil
    }
    if gameStateData.randomQuestion.answerC == firstRandomElement || gameStateData.randomQuestion.answerC == secondRandomElement {
        gameStateData.randomQuestion.answerC = nil
    }
    if gameStateData.randomQuestion.answerD == firstRandomElement || gameStateData.randomQuestion.answerD == secondRandomElement {
        gameStateData.randomQuestion.answerD = nil
    }
}

