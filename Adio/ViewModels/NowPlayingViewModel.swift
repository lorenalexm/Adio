//
//  NowPlayingViewModel.swift
//  Adio
//
//  Created by Alex Loren on 11/25/22.
//

import SwiftUI

class NowPlayingViewModel: ObservableObject {
    // MARK: - Properties
    @Published var songContainer: SongContainer?
}
