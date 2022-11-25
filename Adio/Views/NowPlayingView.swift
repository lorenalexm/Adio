//
//  NowPlayingView.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct NowPlayingView: View {
    // MARK: - View declaration.
    var body: some View {
        GradientBackground {
            VStack {
                HStack {
                    Text("Now Playing")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.text)
                        .padding(20)
                    Spacer()
                }
                
                Spacer()
                
                SongDetails()
                
                HStack(spacing: 60) {
                    Image(systemName: "stop")
                        .font(.system(size: 36))
                        .foregroundColor(.text)
                    Image(systemName: "play")
                        .font(.system(size: 36))
                        .foregroundColor(.text)
                }.padding(.vertical)
                
                Spacer()
            }
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
