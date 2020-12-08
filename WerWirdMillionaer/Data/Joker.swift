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
    
    if [1, 2, 3].contains(gameStateData.currentPrizeLevel) {
        outputSelection = ["Na, das ist doch einfach! \"%@\" natürlich!", "Ja, das weiß ich. Das ist \"%@\"", "Hmm. Nimm \"%@\". Da bin ich mir sicher!", "Ja... ok. Da ist \"%@\" auf jedenfall richtig!", "Easy: \"%@\" kann nur richtig sein.", "Mit \"%@\" kannst ich nur richtig liegen!"]
    } else if [4, 5, 6, 7, 8].contains(gameStateData.currentPrizeLevel) {
        outputSelection = ["Das weiß ich noch aus meiner Schulzeit. Das ist \"%@\".", "\"%@\" sollte korrekt sein.", "Ich schätze \"%@\".", "Lass mich kurz überlegen... \"%@\" sollte stimmen.", "Ich tippe auf \"%@\"", "Da kann ich nur \"%@\" antworten."]
    } else if [9, 10, 11, 12, 13].contains(gameStateData.currentPrizeLevel) {
        outputSelection = ["Ich vermute \"%@\". Bin mir aber nicht 100 prozentig sicher.", "\"%@\" sollte korrekt sein.", "Da hast du ja eine Frage erwischt! Vielleicht \"%@\"?", "Das passt ja gut. Darüber habe ich letztens ein Buch gelesen. Nimm \"%@\"!", "Nicht schlecht. Du hast es ja schon fast geschaft. \"%@\" müsste die Antwort sein."]
    } else if [14, 15].contains(gameStateData.currentPrizeLevel) {
        outputSelection = ["Wow soweit hast du es schon geschafft. Aber eine schwierige Frage. Probiere es mal mit \"%@\".", "Bei dieser Frage kann ich nur meine Vermutung abgeben: \"%@\"", "Herzlichen Glückwunsch schonmal! Gleich hast du es geschaft. Try \"%@\"!", "Ob ich dir da eine große Hilfe bin, weiß ich nicht. Aber ich würde die Antwort \"%@\" nehmen."]
    } else {
        outputSelection = ["Das ist \"%@\"!"]
    }
        
    let guessedAnswer = String(format: outputSelection.randomElement()!, gameStateData.randomQuestion.correctAnswer)
    
    withAnimation {
        gameStateData.telephoneJokerText = guessedAnswer
    }
    
    let utterance = AVSpeechUtterance(string: guessedAnswer)
    utterance.voice = AVSpeechSynthesisVoice(language: "German")
    utterance.volume = 1.0
    utterance.pitchMultiplier = Float.random(in: 0.7..<1.6)
    let speech = AVSpeechSynthesizer()
    speech.speak(utterance)
}

struct VotingVariant: Hashable {
    let name: String
    let height: CGFloat
    let probability: Double
    
    init(name: String, height: CGFloat, probability: Double) {
        self.name = name
        self.height = height
        self.probability = probability
    }
}

class AudiencePollCollection {
    let maximalHeight: CGFloat = 200
    let minHeight: CGFloat = 10
    let width: CGFloat = 50
    
    var votingVariant = [VotingVariant]()
}

func audienceJoker(gameStateData: GameStateData) -> AudiencePollCollection {
    let currentPrizeLevel = gameStateData.currentPrizeLevel - 1 // Subtract one to now include 0 Euro prize level
    
    let audiencePollCollection = AudiencePollCollection()

    var minimumAnswerProbability: Double = 0.60
    var extraProbability: Double = 0
    
    if 0...4 ~= currentPrizeLevel {
        minimumAnswerProbability = 0.85
        extraProbability = Double.random(in: 0.01...0.06)
    } else if 5...8 ~= currentPrizeLevel {
        minimumAnswerProbability = 0.75
        extraProbability = Double.random(in: 0.01...0.08)
    } else if 9...12 ~= currentPrizeLevel {
        minimumAnswerProbability = 0.70
        extraProbability = Double.random(in: 0.01...0.06)
    } else if 13...14 ~= currentPrizeLevel {
        minimumAnswerProbability = 0.60
        extraProbability = Double.random(in: 0.01...0.05)
    }
    
    let probabilityForNonCorrect = 1 - (minimumAnswerProbability + extraProbability)
    
    let firstOtherProbability = Double.random(in: 0...(probabilityForNonCorrect > 3 ? probabilityForNonCorrect - 3 : probabilityForNonCorrect))
    let secondOtherProbability = Double.random(in: 0...(probabilityForNonCorrect - firstOtherProbability))
    let thirdOtherProbability = probabilityForNonCorrect - firstOtherProbability - secondOtherProbability
    
    var currentIndex = 0
    var probabilityIndex = 0
    for answerPossibility in [gameStateData.randomQuestion.answerA,
                              gameStateData.randomQuestion.answerB,
                              gameStateData.randomQuestion.answerC,
                              gameStateData.randomQuestion.answerD] {
        
        var probability: Double = 0
        if answerPossibility == gameStateData.randomQuestion.correctAnswer {
            probability = (minimumAnswerProbability + extraProbability)
        }
        
        if probability == 0 {
            probability = (probabilityIndex == 0 ? firstOtherProbability :
                            (probabilityIndex == 1 ? secondOtherProbability :
                                thirdOtherProbability))
            probabilityIndex += 1
        }
        
        var height: CGFloat = 0
        height = audiencePollCollection.maximalHeight * CGFloat(probability)
        if height < audiencePollCollection.minHeight {
            height = audiencePollCollection.minHeight
        }
        
        var name = ""
        if currentIndex == 0 {
            name = "A"
        } else if currentIndex == 1 {
            name = "B"
        } else if currentIndex == 2 {
            name = "C"
        } else if currentIndex == 3 {
            name = "D"
        }
        
        audiencePollCollection.votingVariant.append(
            VotingVariant(
                name: name,
                height: height,
                probability: probability))
        currentIndex += 1
    }
    
    return audiencePollCollection
}

struct AudienceJokerResultView: View {
    @EnvironmentObject var gameStateData: GameStateData
    
    var audienceJokerNumberFormatter: NumberFormatter
    
    init() {
        audienceJokerNumberFormatter = NumberFormatter()
        audienceJokerNumberFormatter.numberStyle = .percent
        audienceJokerNumberFormatter.locale = Locale(identifier: "de_De")
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            ForEach(gameStateData.audienceJokerData!.votingVariant, id: \.self) { pollSection in
                VStack {
                    Text((audienceJokerNumberFormatter.string(from: NSNumber(value: pollSection.probability)) != nil) ? audienceJokerNumberFormatter.string(from: NSNumber(value: pollSection.probability))! : "")
                        .foregroundColor(Color.white)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .bottom, endPoint: .top))
                        .frame(width: gameStateData.audienceJokerData!.width, height: pollSection.height)

                    Text(pollSection.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hue: 0.0764, saturation: 0.8571, brightness: 0.9882))
                }
            }
        }
        .padding(10)
        .background(Color.black.opacity(0.87))
        .cornerRadius(10)
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}

func fifthfiftyJoker(gameStateData: GameStateData) {
    var answerOptions = [gameStateData.randomQuestion.answerA, gameStateData.randomQuestion.answerB,
                         gameStateData.randomQuestion.answerC, gameStateData.randomQuestion.answerD]
    guard let currentAnswerIndex = answerOptions.firstIndex(of: gameStateData.randomQuestion.correctAnswer) else {
        return
    }
    
    var randomList = [0, 1, 2, 3] // Must be sorted
    randomList.remove(at: currentAnswerIndex)
    let originalRandomElementIndex = randomList.firstIndex(of: randomList.randomElement()!)!
    var firstRandomElementIndex = originalRandomElementIndex
    if firstRandomElementIndex >= currentAnswerIndex {
        firstRandomElementIndex += 1
    }
    answerOptions[firstRandomElementIndex] = nil
    randomList.remove(at: originalRandomElementIndex)
    
    var secondRandomElementIndex = randomList.firstIndex(of: randomList.randomElement()!)!
    if secondRandomElementIndex >= originalRandomElementIndex {
        secondRandomElementIndex += 1
    }
    if secondRandomElementIndex >= currentAnswerIndex {
        secondRandomElementIndex += 1
    }
    answerOptions[secondRandomElementIndex] = nil
    
    gameStateData.randomQuestion.answerA = answerOptions[0]
    gameStateData.randomQuestion.answerB = answerOptions[1]
    gameStateData.randomQuestion.answerC = answerOptions[2]
    gameStateData.randomQuestion.answerD = answerOptions[3]
}

