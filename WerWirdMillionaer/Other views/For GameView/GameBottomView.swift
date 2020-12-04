//
//  GameBottomView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 04.12.20.
//

import SwiftUI

struct GameBottomView: View {
    @EnvironmentObject var gameStateData: GameStateData
    
    var body: some View {
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
}

struct GameBottomView_Previews: PreviewProvider {
    static var previews: some View {
        GameBottomView()
    }
}
