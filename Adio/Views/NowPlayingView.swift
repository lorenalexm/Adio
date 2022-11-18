//
//  NowPlayingView.swift
//  Adio
//
//  Created by Alex Loren on 11/17/22.
//

import SwiftUI

struct NowPlayingView: View {
    // MARK: - Properties
    @State var recentlyPlayedShowing = false
    
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
                
                /*
                Button(action: {
                    recentlyPlayedShowing = true
                }, label: {
                    Text("View recently played")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.text)
                })
                */
            }
        }
        .sheet(isPresented: $recentlyPlayedShowing) {
            VStack {
                HStack {
                    Text("Recently played:")
                        .font(.title3)
                        .padding()
                    Spacer()
                }
                List(0...10, id: \.self) {
                    Text("Artist \($0)")
                        .foregroundColor(.text)
                }
                .scrollContentBackground(.hidden)
            .presentationDetents([.medium])
            }
        }
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
