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
            Text("Antwort A: ")
            Text("Antwort B: ")
            Text("Antwort C: ")
            Text("Antwort D: ")
        }
        .navigationBarHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
