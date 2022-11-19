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
                
                RoundedRectangle(cornerRadius: 32)
                    .frame(width: 250, height: 250)
                    .foregroundColor(.white)
                    .shadow(radius: 24)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Track name")
                            .font(.headline)
                            .foregroundColor(.text)
                        Text("Artist name")
                            .font(.subheadline)
                            .foregroundColor(.text)
                    }.padding(.vertical)
                    
                    Spacer()
                    
                    Text("00:00 / 00:00")
                        .font(.subheadline)
                        .foregroundColor(.text)
                }.padding(.horizontal, 40)
                
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
