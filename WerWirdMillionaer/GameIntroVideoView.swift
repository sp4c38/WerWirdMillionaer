//
//  GameIntroVideoView.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 04.12.20.
//

import AVKit
import SwiftUI

struct AVPlayerView: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.showsPlaybackControls = false
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.modalPresentationStyle = .fullScreen
        uiViewController.player = player
        uiViewController.player!.play()
        uiViewController.videoGravity = .resizeAspectFill
    }
}

struct GameIntroVideoView: View {
    @EnvironmentObject var mainViewController: MainViewController
    
    var resourceBundleUrl: URL? = nil
    var player: AVPlayer? = nil

    var videoPublisher = NotificationCenter.default.publisher(for: Notification.Name.AVPlayerItemDidPlayToEndTime)
    
    init() {
        resourceBundleUrl = Bundle.main.url(forResource: "GameIntroVideo", withExtension: "mp4")
        if resourceBundleUrl != nil {
            player = AVPlayer(url: resourceBundleUrl!)
        }
    }
    
    var body: some View {
        VStack {
            if player != nil {
                AVPlayerView(player: player!)
            }
        }
        .onReceive(videoPublisher) { output in
            mainViewController.changeViewShowIndex(newViewNumber: 2)
        }
        .ignoresSafeArea(.all)
    }
}

struct GameIntroVideoView_Previews: PreviewProvider {
    static var previews: some View {
        GameIntroVideoView()
    }
}
