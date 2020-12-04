//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class GameStateData: ObservableObject {
    @Published var currentPrizeLevel: Int = 1
    @Published var oldCurrentPrizeLevel: Int = 0
    
    @Published var questionAnsweredCorrectly: Bool? = nil
    
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
        if currentPrizeLevel + 2 <= questionData!.prizeLevels.count {
            self.currentPrizeLevel += 1
            oldCurrentPrizeLevel += 1
        } else {
            print("Maximum prize level reached. Staying on \(currentPrizeLevel) prize level")
        }
    }
    
    func updateRandomQuestion() {
        self.randomQuestion = questionData!.prizeLevels[currentPrizeLevel].questions.randomElement()!
        self.randomQuestionAnswerIndexes = []
        for _ in 1...4 {
            var randomAnswerIndex = [0, 1, 2, 3].randomElement()!
            while self.randomQuestionAnswerIndexes.contains(randomAnswerIndex) {
                randomAnswerIndex = [0, 1, 2, 3].randomElement()!
            }
            
            self.randomQuestionAnswerIndexes.append(randomAnswerIndex)
        }
    }
}

struct GameView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
    var prizesLoadedSuccessful: Bool = false
    
    init() {
        if questionData != nil {
            prizesLoadedSuccessful = true
        } else {
            prizesLoadedSuccessful = false
        }
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            VStack(spacing: 0) {
                if prizesLoadedSuccessful {
                    GameHeaderView() // Includes: end button, the prize money which can be won in the current round

                    Spacer()
                    Spacer()

                    GameCenterView() // Includes: Joker buttons, timer, prizes view
                        
                    Spacer()
                        
                    GameBottomView() // Includes: picture of the moderator, answer, answer options
                } else {
                    Text("Fragen konnten nicht geladen werden.")
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Image("MainBackground")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 15)
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.2))
        }
        .onAppear {
            // Comment when using Canvas
            let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, previousPrizeLevel: gameStateData.oldCurrentPrizeLevel)
            soundManager.playBackgroundMusic(soundUrl: backgroundSoundUrl)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 961))
            .environmentObject(SoundManager())
            .environmentObject(MainViewController())
            .environmentObject(GameStateData())
    }
}
