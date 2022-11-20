//
//  RecentlyPlayedViewModelTests.swift
//  AdioTests
//
//  Created by Alex Loren on 11/19/22.
//

import XCTest
@testable import Adio

@MainActor final class RecentlyPlayedViewModelTests: XCTestCase {
    // MARK: - Tests.
    /// Fetches the now playing information from the AzuraCast demo server. Attempts to parse the song history from the data.
    /// This test may fail if near the bottom of the hour, as the server metrics reset hourly.
    func testFetchingRecentlyPlayed() async {
        let viewModel = RecentlyPlayedViewModel()

        XCTAssertEqual(viewModel.recentlyPlayed.count, 0)
        _ = try? await viewModel.fetchRecentlyPlayed(from: "https://demo.azuracast.com/api/nowplaying")
        XCTAssertEqual(viewModel.recentlyPlayed.count, 5)
    }
}
