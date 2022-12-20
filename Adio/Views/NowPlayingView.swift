//
//  NowPlayingView.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct NowPlayingView: View {
    // MARK: - Properties.
    @EnvironmentObject private var socketClient: SocketClient
    @EnvironmentObject private var player: StreamPlayer
    
    // MARK: - View declaration.
    var body: some View {
        GradientBackground {
            VStack {
                HStack {
                    Text("Now")
                        .font(.system(size: 72))
                        .fontWeight(.black)
                        .foregroundLinearGradient(colors: [.cirton, .cirton, .hope], startingAt: .topLeading, endingAt: .bottomTrailing)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                HStack {
                    Text("Playing")
                        .font(.system(size: 72))
                        .fontWeight(.black)
                        .foregroundLinearGradient(colors: [.cirton, .cirton, .hope], startingAt: .topLeading, endingAt: .bottomTrailing)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .padding(.top, -75)
                
                Spacer()
                
                if socketClient.nowPlaying != nil {
                    SongDetails()
                    
                    HStack(spacing: 60) {
                        if StreamPlayer.shared.isPlaying {
                            Button(action: onPauseTapped) {
                                Image(systemName: "pause.fill")
                                    .font(.system(size: 48))
                                    .foregroundColor(.text)
                            }
                        } else {
                            Button(action: onPlayTapped) {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 48))
                                    .foregroundColor(.text)
                            }
                        }
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
    }
    
    // MARK: - Functions.
    /// Configures the remote stream and begins playing audio.
    func onPlayTapped() {
        guard let url = socketClient.radioUrl,
        let container = socketClient.nowPlaying else {
            print("Invalid radio url provided!")
            return
        }
        StreamPlayer.shared.play(from: url)
        StreamPlayer.shared.updateNowPlaying(with: container)
    }
    
    /// Pauses the remote stream audio.
    func onPauseTapped() {
        StreamPlayer.shared.pause()
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    // MARK: - Properties.
    static var socketClient = SocketClient()
    
    // MARK: - View declaration
    static var previews: some View {
        NowPlayingView()
            .environmentObject(socketClient)
    }
}
