//
//  GameIntroVideoView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 04.12.20.
//

import AVKit
import SwiftUI

struct GameIntroViewRepresentable: UIViewControllerRepresentable {
    var player: AVPlayer
    
//    class Coordinator {
//        init()
//        }
//    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        var playerViewController = AVPlayerViewController()
        playerViewController.showsPlaybackControls = false
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.modalPresentationStyle = .fullScreen
        uiViewController.player = player
        uiViewController.player!.play()
    }
}

struct GameIntroVideoView: View {
    var resourceBundleUrl: URL? = nil
    var player: AVPlayer? = nil
    
    init() {
        resourceBundleUrl = Bundle.main.url(forResource: "GameIntroVideo", withExtension: "mp4")
        if resourceBundleUrl != nil {
            player = AVPlayer(url: resourceBundleUrl!)
        }
    }
    
    var body: some View {
        VStack {
            if player != nil {
                GameIntroViewRepresentable(player: player!)
//                VideoPlayer(player: player!)
//
//                    .onAppear {
//                        player!.play()
//                    }
//                    .onChange(of: player!.status) { newStatus in
//                        print(newStatus)
//                    }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct GameIntroVideoView_Previews: PreviewProvider {
    static var previews: some View {
        GameIntroVideoView()
    }
}
