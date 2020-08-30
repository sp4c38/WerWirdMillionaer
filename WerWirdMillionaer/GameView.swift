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
            Text("Frage: ")
            HStack {
                Text("Antwort A: ")
                Spacer()
                Text("Antwort B: ")
            }
            HStack {
                Text("Antwort C: ")
                Spacer()
                Text("Antwort D: ")
            }
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
