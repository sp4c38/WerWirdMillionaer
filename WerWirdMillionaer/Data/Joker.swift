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
                    Text((audienceJokerNumberFormatter.string(from: pollSection.probability) != nil) ? audienceJokerNumberFormatter.string(from: pollSection.probability)! : "")
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

