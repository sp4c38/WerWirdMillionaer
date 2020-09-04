//
//  ContentView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Image("wwm_logo")
                    .resizable()
                    .scaledToFit() 
                    .frame(height: 500)
                    .padding(.top, -30)
                    .padding(.bottom, -130) // Remove some space because of the sunbeams aroung the wwm logo
                
                HStack {
                    Spacer()
                }
                
                HStack(spacing: 50) {
                    Image("guenter_jauch")
                        .resizable()
                        .scaledToFit()
                        .padding(.leading, 40)
                        .shadow(radius: 10)
                    
                    NavigationLink(destination: GameView()) {
                        Text("Starten!")
                            .foregroundColor(Color.white)
                            .font(.system(size: 30, weight: .semibold))
                            .fixedSize(horizontal: true, vertical: false)
                            .lineLimit(1)
                            .padding()
                            .padding(.leading, 170)
                            .padding(.trailing, 170)
                            .background(
                                ZStack {
                                    AnswerButtonShape()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.6130, saturation: 1.0000, brightness: 0.4510), Color.blue]), startPoint: .top, endPoint: .bottom))
                                    AnswerButtonShape()
                                        .stroke(Color.white, lineWidth: 3)
                                }
                            )
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
