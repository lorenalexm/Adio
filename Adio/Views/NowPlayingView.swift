//
//  NowPlayingView.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct NowPlayingView: View {
    // MARK: - Properties.
    @EnvironmentObject var player: Player
    
    // MARK: - View declaration.
    var body: some View {
        GradientBackground {
            VStack {
                HStack {
                    Text("Now Playing")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.cirton)
                        .padding(20)
                    Spacer()
                }
                
                Spacer()
                
                if let container = player.nowPlaying {
                    SongDetails(songContainer: Binding<SongContainer>(get: { container }, set: { player.nowPlaying = $0 }))
                    
                    HStack(spacing: 60) {
                        Image(systemName: "stop")
                            .font(.system(size: 36))
                            .foregroundColor(.text)
                        Image(systemName: "play")
                            .font(.system(size: 36))
                            .foregroundColor(.text)
                    }.padding(.vertical)
                } else {
                    ProgressView()
                        .tint(.text)
                        .scaleEffect(2, anchor: .center)
                        .padding()
                    Text("Loading now playing..")
                        .foregroundColor(.text)
                }
                
                Spacer()
            }
        }
        .task {
            print("Hello, world.")
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    // MARK: - Properties.
    static var player = Player()
    
    // MARK: - View declaration
    static var previews: some View {
        NowPlayingView()
            .environmentObject(player)
    }
}
