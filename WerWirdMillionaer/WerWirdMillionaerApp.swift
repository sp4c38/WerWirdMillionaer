//
//  WerWirdMillionaerApp.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 29.08.20.
//

import AVFoundation
import SwiftUI

@main
struct WerWirdMillionaerApp: App {
    var soundManager = SoundManager()
    var mainViewController = MainViewController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(soundManager)
                .environmentObject(mainViewController)
        }
    }
}
