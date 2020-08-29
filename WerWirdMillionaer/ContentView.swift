//
//  ContentView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Text("Wirst du Millionär?")
                    .bold()
                    .foregroundColor(Color.white)
                    .font(.system(size: 40))
                    .padding(.top, 100)
                    .padding(.bottom, 20)

                Image("wwm_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    .padding(.bottom, 50)

                NavigationLink(destination: GameView()) {
                    Text("Spiel starten")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                ButtonShape()
                                    .fill(Color(hue: 0.6130, saturation: 1.0000, brightness: 0.4510))
                                ButtonShape()
                                    .stroke(Color.white, lineWidth: 3)
                            }
                        )
                        .padding(.leading, 200)
                        .padding(.trailing, 200)
                }

                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
