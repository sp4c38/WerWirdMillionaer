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
            VStack {
                if prizesLoadedSuccessful {
                    TopHeaderView()

                    Spacer()
                    
                    VStack(spacing: 0) {
                        Spacer()

                        HStack {
                            JokerButtonsView()

                            if gameStateData.audienceJokerData != nil {
                                Spacer()
                                AudienceJokerResultView()
                                Spacer()
                            }
                            
                            if gameStateData.telephoneJokerText != nil {
                                Spacer()
                                Text(gameStateData.telephoneJokerText!)
                                    .foregroundColor(Color.black)
                                    .padding(20)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 20)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                                    .transition(.opacity)
                                    .animation(.easeInOut(duration: 4))
                                Spacer()
                            }
                            
                            if gameStateData.telephoneJokerText == nil && gameStateData.audienceJokerData == nil {
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            
                            TimeRemainingCircleView()

                            if gameStateData.telephoneJokerText == nil || gameStateData.audienceJokerData == nil {
                                Spacer()
                                Spacer()
                            } else {
                                Spacer()
                            }
                            
                            PrizesView()
                        }
                        .padding(.leading, 40)
                        .padding(.trailing, 40)

                        Spacer()
                        
                        HStack(spacing: 0) {
                            Image("GuenterJauchOnChair")
                                .resizable()
                                .scaledToFit()
                                .padding(.leading, 3)
                                .padding(.top, -70)
                            
                            VStack {
                                QuestionTextView(question: gameStateData.randomQuestion.question)
                                    .padding(.bottom, 20)

                                HStack(spacing: 0) {
                                    VStack(spacing: 40) {
                                        AnswerButton(answerName: "A", showingIndex: gameStateData.randomQuestionAnswerIndexes[0])
                                        AnswerButton(answerName: "B", showingIndex: gameStateData.randomQuestionAnswerIndexes[1])
                                    }

                                    VStack(spacing: 40) {
                                        AnswerButton(answerName: "C", showingIndex: gameStateData.randomQuestionAnswerIndexes[2])
                                        AnswerButton(answerName: "D", showingIndex: gameStateData.randomQuestionAnswerIndexes[3])
                                    }
                                }
                            }
                            .padding(.bottom, 40)
                        }
                        .padding(.trailing, 40)
                    }
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
            .navigationBarHidden(true)
            .animation(.easeInOut(duration: 0.2))
        }
        .onAppear {
            // Comment when using Canvas
            let backgroundSoundUrl = getBackgroundAudioUrl(currentPrizesLevel: gameStateData.currentPrizeLevel, oldCurrentPrizeLevel: gameStateData.oldCurrentPrizeLevel)
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
