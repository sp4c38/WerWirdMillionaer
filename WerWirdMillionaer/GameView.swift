//
//  GameView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct GameView: View {
    
    var body: some View {
        VStack {
            Text("Frage: \(prizesData!.prizeLevels[0].questions[0].question)")
//            HStack {
//                Text("Antwort A: \(questionData!.hello[0].answer_a)")
//                Spacer()
//                Text("Antwort C: \(questionData!.hello[0].answer_c)")
//            }
//            HStack {
//                Text("Antwort B: \(questionData!.hello[0].answer_b)")
//                Spacer()
//                Text("Antwort D: \(questionData!.hello[0].answer_d)")
//            }
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
