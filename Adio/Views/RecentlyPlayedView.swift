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
                        ForEach(recent, id: \.shID) { container in
                            HStack {
                                if let artURL = container.song.art {
                                    AsyncImage(url: URL(string: artURL), transaction: Transaction(animation: .spring())) { phase in
                                        switch phase {
                                        case .empty:
                                            RoundedRectangle(cornerRadius: 8)
                                                .frame(width: 48, height: 48)
                                                .foregroundColor(.white)
                                                .shadow(radius: 20)
                                                .transition(.scale)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 48, height: 48)
                                                .cornerRadius(8)
                                                .shadow(radius: 20)
                                                .transition(.scale)
                                        default:
                                            Text("Error fetching art!")
                                                .font(.title2)
                                                .fontWeight(.black)
                                                .foregroundColor(.text)
                                        }
                                    }
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
