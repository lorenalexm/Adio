//
//  AdioApp.swift
//  Adio
//
//  Created by Alex Loren on 11/16/22.
//

import SwiftUI

@main
struct AdioApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NowPlayingView()
                    .tabItem {
                        Label("Now Playing", systemImage: "play.fill")
                    }
            }
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
