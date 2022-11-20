//
//  RecentlyPlayedViewModel.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import SwiftUI

@MainActor class RecentlyPlayedViewModel: ObservableObject {
    // MARK: - Properties.
    @Published var recentlyPlayed = [SongContainer]()
    private var urlSession = URLSession.shared
    
    // MARK: - Functions.
    
    /// Fetches the Radio from the remote `URL` and attempts to parse the `Song` history from the data.
    /// - Parameter url: The `URL` of the remote AzuraCast server.
    /// - Returns: An array of `SongContainer` objects, guarenteed to have 1 or more elements.
    /// - Throws: `URLError.badServerResponse` if status code does not equal 200.
    /// - Throws: A `fatalError` if the song history does not contain at least one element.
    public func fetchRecentlyPlayed(from url: String) async throws -> [SongContainer] {
        let (data, response) = try await urlSession.data(from: URL(string: url)!)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let fetched = try JSONDecoder().decode(Radio.self, from: data)
        guard fetched.count > 0,
              let recentlyPlayed: [SongContainer] = fetched[0].songHistory,
              recentlyPlayed.count > 0 else {
            fatalError("Failed to decode recently played")
        }
        
        self.recentlyPlayed = recentlyPlayed
        return recentlyPlayed
    }
}
