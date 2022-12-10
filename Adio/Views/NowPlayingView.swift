//
//  NowPlayingView.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct NowPlayingView: View {
    // MARK: - Properties.
    let viewModel = NowPlayingViewModel()
    
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
                
                if let container = viewModel.songContainer {
                    SongDetails(songContainer: Binding<SongContainer>(get: { container }, set: { viewModel.songContainer = $0 }))
                    
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
    static var previews: some View {
        NowPlayingView()
    }
}
