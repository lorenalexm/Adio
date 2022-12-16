//
//  AdioApp.swift
//  Adio
//
//  Created by Alex Loren on 11/16/22.
//

import SwiftUI

@main
struct AdioApp: App {
    // MARK: - Properties.
    @StateObject private var socketClient = SocketClient()
    @StateObject private var player = StreamPlayer.shared
    
    // MARK: - View declaration.
    var body: some Scene {
        WindowGroup {
            TabView {
                NowPlayingView()
                    .tabItem {
                        Label("Now Playing", systemImage: "play.fill")
                    }
                
                RecentlyPlayedView()
                    .tabItem {
                        Label("Recently Played", systemImage: "clock.fill")
                    }
            }
            .environmentObject(socketClient)
            .environmentObject(player)
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                //appearance.backgroundColor = UIColor(Color.backgroundLight.opacity(0.2))
                
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            .tint(Color.text)
        }
    }
}
