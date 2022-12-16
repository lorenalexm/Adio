//
//  NowPlayingView.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct NowPlayingView: View {
    // MARK: - Properties.
    @EnvironmentObject var socketClient: SocketClient
    @EnvironmentObject var player: StreamPlayer
    
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
                
                if let container = socketClient.nowPlaying {
                    SongDetails(songContainer: Binding<SongContainer>(get: { container }, set: { socketClient.nowPlaying = $0 }))
                    
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
        .task {
            print("Hello, world.")
        }
    }
    
    // MARK: - Functions.
    /// Configures the remote stream and begins playing audio.
    func onPlayTapped() {
        guard let url = socketClient.radioUrl else {
            print("Invalid radio url provided!")
            return
        }
        StreamPlayer.shared.play(from: url)
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
