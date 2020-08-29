//
//  ContentView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
                .padding(.bottom, 100)
            
            Button(action: {
                
            }) {
                Text("Spielen")
                    .foregroundColor(Color.white)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 2732, height: 2048))
    }
}
