//
//  PlayingNext.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - PlayingNext
struct PlayingNext: Codable {
    let cuedAt: Int?
    let playedAt: Int?
    let duration: Int?
    let playlist: String?
    let isRequest: Bool?
    let song: Song?

    enum CodingKeys: String, CodingKey {
        case cuedAt = "cued_at"
        case playedAt = "played_at"
        case duration = "duration"
        case playlist = "playlist"
        case isRequest = "is_request"
        case song = "song"
    }
}
