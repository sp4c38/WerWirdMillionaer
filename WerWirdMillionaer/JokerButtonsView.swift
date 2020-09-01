//
//  JokerButtonsView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 01.09.20.
//

import SwiftUI

struct JokerButtonsView: View {
    @Binding var jokerGuess: String
    var currentPrizesLevel: CurrentPrizesLevel
    
    var body: some View {
        VStack {
            ZStack {
                Button (action: {
                }) {
                    Image("50-50")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
            }
            
            ZStack {
                Button (action: {

                }) {
                    Image("audience")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
            }
            
            ZStack {
                Button (action: {
                    jokerGuess = telephoneJoker(currentPrizesLevel: currentPrizesLevel)
                }) {
                    Image("telephone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
            }
        }
    }
}
