//
//  RecentlyPlayedView.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import SwiftUI

struct RecentlyPlayedView: View {
    // MARK: - Properties.
    @ObservedObject private var viewModel = RecentlyPlayedViewModel()
    
    // MARK: - View declaration.
    var body: some View {
        GradientBackground {
            if viewModel.recentlyPlayed.count == 0 {
                Text("Loading..")
                    .font(.largeTitle)
                    .foregroundColor(.text)
            } else {
                List {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.recentlyPlayed, id: \.shID) { songContainer in
                            Text(songContainer.song.title)
                                .font(.headline)
                            Text(songContainer.song.artist)
                                .font(.subheadline)
                            Divider()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .task {
            do {
                _ = try await viewModel.fetchRecentlyPlayed(from: "https://demo.azuracast.com/api/nowplaying")
            } catch {
                print("Error fetching recently played songs. Server returned with an error: \(error.localizedDescription)")
            }
        }
        .refreshable {
            do {
                _ = try await viewModel.fetchRecentlyPlayed(from: "https://demo.azuracast.com/api/nowplaying")
            } catch {
                print("Error fetching recently played songs. Server returned with an error: \(error.localizedDescription)")
            }
        }
    }
}

struct RecentlyPlayedView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyPlayedView()
    }
}
