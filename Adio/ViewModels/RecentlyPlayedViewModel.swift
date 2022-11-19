//
//  RecentlyPlayedViewModel.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import SwiftUI

@MainActor class RecentlyPlayedViewModel: ObservableObject {
    // MARK: - Properties.
    @Published var recentlyPlayed = RecentlyPlayed()
}
