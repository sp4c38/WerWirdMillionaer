//
//  ContentView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

class MainViewController: ObservableObject {
    @Published var onHomeView = true
    
    func goBackToStartView() {
        onHomeView.toggle()
    }
}

struct ContentView: View {
    @ObservedObject var mainViewController = MainViewController()
    
    var body: some View {
        if mainViewController.onHomeView {
            HomeView()
                .environmentObject(mainViewController)
        } else {
            GameView()
                .environmentObject(mainViewController)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 761))
    }
}
