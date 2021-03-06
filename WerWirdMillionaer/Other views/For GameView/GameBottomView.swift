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
                .padding(.leading, 33)
                .padding(.top, -70)
            
            VStack {
                QuestionTextView(question: gameStateData.randomQuestion.question)
                    .padding(.bottom, 20)

                HStack(spacing: 0) {
                    VStack(spacing: 40) {
                        AnswerButton(answerName: "A", 0)
                        AnswerButton(answerName: "C", 2)
                    }

                    VStack(spacing: 40) {
                        AnswerButton(answerName: "B", 1)
                        AnswerButton(answerName: "D", 3)
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
