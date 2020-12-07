//
//  TimeRemainingCircleView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 05.09.20.
//

import SwiftUI

struct WedgeOfCircle: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.size.width
        let height = rect.size.height
        
        let center = CGPoint(x: width / 2, y: height / 2)
        
        let lineStart: CGFloat = height / 2
        let lineWidth: CGFloat = 20
        
        path.addArc(center: center, radius: lineStart - lineWidth, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        path.addArc(center: center, radius: lineStart, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        
        return path
    }
}

struct Wedge: Hashable {
    var isActive: Bool
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
}

struct CircleStatusView: View {
    var allWedgeNumber: Int
    var wedgeNumber: Int
    var wedges = [Wedge]()
    
    init(allWedgeNumber: Int, wedgeNumber: Int) {
        // allWedgeNumber: Number which shows how many wedges there are all together
        // wedgeNumber: Number which shows how many wedges still exist
        
        self.allWedgeNumber = allWedgeNumber
        self.wedgeNumber = wedgeNumber
        
        let singleWedgeDegree: Double = Double(360 / allWedgeNumber)
        var lastWedgeDegree: Double = -108.5
        var lastWedgeColor = true // Switch between colors by turns

        for currentWedgeNumber in 0...allWedgeNumber {
            let newWedge = Wedge(
                                isActive: ((currentWedgeNumber <= wedgeNumber) ? true : false),
                                startAngle: .degrees(lastWedgeDegree),
                                endAngle: .degrees(lastWedgeDegree + singleWedgeDegree - 1),
                                color: ((currentWedgeNumber <= wedgeNumber) ? Color.orange : Color.gray))
            
            self.wedges.append(newWedge)
            lastWedgeColor.toggle()
            lastWedgeDegree = lastWedgeDegree + singleWedgeDegree
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(wedges, id: \.self) { wedge in
                WedgeOfCircle(startAngle: wedge.startAngle, endAngle: wedge.endAngle)
                    .fill(wedge.color)
            }
        }
    }
}

struct TimeRemainingCircleView: View {
    @EnvironmentObject var soundManager: SoundManager
    @EnvironmentObject var gameStateData: GameStateData
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var scaleSmall = true
    
    var timeNumberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        return numberFormatter
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .frame(width: 300, height: 300)
                
                Image("CounterBackgroundImage")
                    .resizable()
                    .cornerRadius(100000)
                    .blur(radius: 10)
                    .frame(width: 300, height: 300)
                    
                Text(String(gameStateData.timeRemaining))
                    .bold()
                    .font(.system(size: 120))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(25)
                    .animation(nil)
            }
            
            CircleStatusView(allWedgeNumber: gameStateData.timeAllAvailable, wedgeNumber: gameStateData.timeRemaining)
                .frame(width: 340, height: 340)
        }
        .scaleEffect(scaleSmall ? 1 : 1.1)
        .onReceive(timer) { _ in
            if !(gameStateData.timeRemaining == 0 || gameStateData.timeRemaining < 0) {
                if gameStateData.timeKeepCounting {
                    gameStateData.timeRemaining -= 1
                    scaleSmall.toggle()
                }
            } else {
                gameStateData.timeOver = true
                gameStateData.timeKeepCounting = false
                gameStateData.questionAnsweredCorrectly = false
            }
        }
    }
}
