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
            if let recent = socketClient.recentlyPlayed {
                if recent.count == 0 {
                    Text("Loading..")
                        .font(.largeTitle)
                        .foregroundColor(.text)
                } else {
                    List {
                        VStack(alignment: .leading) {
                            ForEach(recent, id: \.shID) { container in
                                Text(container.song.title)
                                    .font(.headline)
                                Text(container.song.artist)
                                    .font(.subheadline)
                                Divider()
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
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
