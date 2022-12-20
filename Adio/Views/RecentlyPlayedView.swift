//
//  RecentlyPlayedView.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import SwiftUI

struct RecentlyPlayedView: View {
    // MARK: - Properties.
    @EnvironmentObject private var socketClient: SocketClient
    
    // MARK: - View declaration.
    var body: some View {
        GradientBackground {
            if let recent = socketClient.recentlyPlayed, recent.count > 0 {
                List {
                    ForEach(recent, id: \.shID) { container in
                        HStack {
                            if let artURL = container.song.art {
                                RoundedUrlImageView(from: URL(string: artURL)!, width: 64, height: 64, shadowRadius: 5)
                                    .padding(.trailing)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(container.song.title)
                                    .font(.headline)
                                Text(container.song.artist)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            } else {
                Text("Unable to load recently played songs.")
                    .font(.title)
                    .foregroundColor(.text)
            }
        }
    }
}

struct RecentlyPlayedView_Previews: PreviewProvider {
    // MARK: - Properties.
    static let socketClient = SocketClient()
    
    // MARK: - View declaration.
    static var previews: some View {
        RecentlyPlayedView()
            .environmentObject(socketClient)
    }
}
