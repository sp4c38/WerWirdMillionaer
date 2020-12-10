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
    var maxPrizeLevel = 15
    
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
    @Published var gameWon: Bool = false
    
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
        self.softStop = nil
        self.gameWon = false
    }
    
    func nextPrizeLevel() {
        self.answerSubmitted = nil
        self.questionAnsweredCorrectly = nil

        self.telephoneJokerText = nil
        self.audienceJokerData = nil
        
        if currentPrizeLevel + 1 <= questionData!.prizeLevels.count {
            self.currentPrizeLevel += 1
            self.oldCurrentPrizeLevel += 1
        } else {
            print("Maximum prize level reached. Staying on \(currentPrizeLevel) prize level")
        }
        
        if self.currentPrizeLevel == 13 {
            self.timeAllAvailable = 45
            print("Reached a high prize level. Therefor changed total available time to \(self.timeAllAvailable)")
        }
        
        self.timeRemaining = self.timeAllAvailable
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel - 1].questions.randomElement()! // Subtract 1 of the currentPrizeLevel because there is no 0 Euro prize level in questionData.prizeLevels | currentPrizeLevel = 0 refers to the 0 Euro prize level. Because currentPrizeLevel at initialization is 1, subtract one to get the 0th prize level from questionData.prizeLevelss.
        self.randomQuestion.shuffleOrder()
    }
}
