//
//  SongDetailsViewModel.swift
//  Adio
//
//  Created by Alex Loren on 11/25/22.
//

import SwiftUI

class SongDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var songContainer: SongContainer
    
    // MARK: - Functions
    init(songContainer: SongContainer) {
        self.songContainer = songContainer
    }
}
