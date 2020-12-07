//
//  GameStateData.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 05.12.20.
//

import Foundation

class GameStateData: ObservableObject {
    @Published var currentPrizeLevel: Int = 1
    @Published var oldCurrentPrizeLevel: Int = 0
    
    @Published var questionAnsweredCorrectly: Bool? = nil
    @Published var answerSubmitted: String? = nil
    
    @Published var randomQuestion = Question(question: "", answerA: "", answerB: "", answerC: "", answerD: "", correctAnswer: "")
    @Published var randomQuestionAnswerIndexes = [Int]() // Will contain four unique numbers each time the question is updated to show the answer options randomly on the Game View
    
    @Published var timeAllAvailable = 30 // Time altogether avaliable to answer a question
    @Published var timeRemaining = 30 // Remaining time in seconds (must be same as timeAllAvailable)
    @Published var timeKeepCounting = true // Indicates if the timer counts
    @Published var timeOver = false // Set to true if the time is over
    
    @Published var telephoneJokerActive = true
    @Published var telephoneJokerText: String? = nil
    @Published var audienceJokerActive = true
    @Published var fiftyfiftyJokerActive = true
    @Published var audienceJokerData: AudiencePollCollection? = nil
    
    @Published var softStop: Bool? = nil // Is set to true if player pressed the stop button
                                         // Is set to false if player selected a wrong answer or the time expired
    
    func resetForNextGame() {
        self.currentPrizeLevel = 1
        self.oldCurrentPrizeLevel = 0
        self.questionAnsweredCorrectly = nil
        self.answerSubmitted = nil
        self.randomQuestion = Question(question: "", answerA: "", answerB: "", answerC: "", answerD: "", correctAnswer: "")
        self.randomQuestionAnswerIndexes = [Int]()
        self.timeAllAvailable = 30
        self.timeRemaining = 30
        self.timeKeepCounting = true
        self.timeOver = false
        self.telephoneJokerActive = true
        self.telephoneJokerText = nil
        self.audienceJokerActive = true
        self.fiftyfiftyJokerActive = true
        self.audienceJokerData = nil
        self.softStop = false
    }
    
    func nextPrizeLevel() {
        self.answerSubmitted = nil
        self.questionAnsweredCorrectly = nil

        self.telephoneJokerText = nil
        self.audienceJokerData = nil

        self.timeRemaining = self.timeAllAvailable
        
        if currentPrizeLevel + 2 <= questionData!.prizeLevels.count {
            self.currentPrizeLevel += 1
            oldCurrentPrizeLevel += 1
        } else {
            print("Maximum prize level reached. Staying on \(currentPrizeLevel) prize level")
        }
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel].questions.randomElement()!
        self.randomQuestion.shuffleOrder()
    }
}
