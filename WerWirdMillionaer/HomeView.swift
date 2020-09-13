//
//  HomeView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 05.09.20.
//

import SwiftUI

struct elementGlowModifier: ViewModifier {
    var color: Color
    @Binding var blurRadius: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .shadow(color: color, radius: blurRadius)
    }
}

struct QuestionmarkModifier: ViewModifier {
    @Binding var blurRadius: CGFloat
    
    func body(content: Content) -> some View {
        return content
            .shadow(color: Color.white, radius: blurRadius)
            .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth: blurRadius)
                    .shadow(color: Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), radius: blurRadius + 2, x: 2, y: 2)
                    .shadow(color: Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980), radius: blurRadius + 2, x: -3, y: -5)
            )
    }
}

struct HomeView: View {
    @EnvironmentObject var mainViewController: MainViewController
    
    @State var elementGlowShadow: CGFloat = 10
    @State var backgroundShadowWidth: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("WWMLogo")
                .resizable()
                .scaledToFit()
                .padding(50)
                .padding(.top, 30)
                .padding(.bottom, -50) // Space removed because of background glowing
                .modifier(elementGlowModifier(color: Color.white, blurRadius: $elementGlowShadow))
                .padding(10)
                .animation(Animation.easeInOut.speed(0.1).repeatForever())
                .onAppear() {
                    withAnimation {
                        self.elementGlowShadow = 30
                    }
                }
            
            HStack(spacing: 90) {
                Image("GuenterJauch")
                    .resizable()
                    .scaledToFit()
                    .padding(.leading, 40)
                    .shadow(radius: 10)
                
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
                    .onTapGesture {
                        mainViewController.goToGameView()
                    }
                    .modifier(elementGlowModifier(color: Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), blurRadius: $elementGlowShadow))
                    .padding(10)
                    .animation(Animation.easeInOut.speed(0.1).repeatForever())
                    .onAppear() {
                        withAnimation {
                            self.elementGlowShadow = 60
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .fill(Color(hue: 0.6429, saturation: 1.0000, brightness: 0.4118))//LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .modifier(QuestionmarkModifier(blurRadius: $backgroundShadowWidth))
                .animation(Animation.easeInOut.speed(0.1).repeatForever())
                .onAppear() {
                    withAnimation {
                        self.backgroundShadowWidth = 8
                    }
                }
        )
        .ignoresSafeArea()
        .preferredColorScheme(.light)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.fixed(width: 1000, height: 761))
            .environmentObject(MainViewController())
    }
}
