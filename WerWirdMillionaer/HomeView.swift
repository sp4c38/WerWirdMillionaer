//
//  HomeView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 05.09.20.
//

import SwiftUI

struct QuestionmarkModifier: ViewModifier {
    let color: Color
    @Binding var blurRadius: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            content.shadow(color: Color.white, radius: blurRadius)
        }
        .padding(10)
        
    }
}

struct HomeView: View {
    @EnvironmentObject var mainViewController: MainViewController
    @State var shadow: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                Image("wwm_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .padding(.top, 50)
                    .padding(.bottom, 50) // Remove some space because of the sunbeams aroung the wwm logo
                    .modifier(QuestionmarkModifier(color: Color.red, blurRadius: $shadow))
                    .animation(Animation.easeInOut.speed(0.15).repeatForever())
                    .onAppear() {
                        withAnimation {
                            self.shadow = 40
                        }
                    }
                
                
                Text("❓")
                    .font(.system(size: 220))
                    .padding()
            }
            
            HStack(spacing: 90) {
                Image("guenter_jauch")
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
                        mainViewController.onHomeView.toggle()
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.5393, saturation: 0.7863, brightness: 0.9725), Color(hue: 0.5871, saturation: 0.9888, brightness: 0.6980)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.fixed(width: 1000, height: 761))
            .environmentObject(MainViewController())
    }
}
