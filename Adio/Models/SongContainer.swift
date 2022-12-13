//
//  NowPlaying.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - NowPlaying
struct SongContainer: Codable {
    let shID: Int
    let playedAt: Int?
    let duration: Int
    let playlist: String
    let streamer: String?
    let isRequest: Bool?
    let song: Song
    let elapsed: Int?
    let remaining: Int?

    enum CodingKeys: String, CodingKey {
        case shID = "sh_id"
        case playedAt = "played_at"
        case duration = "duration"
        case playlist = "playlist"
        case streamer = "streamer"
        case isRequest = "is_request"
        case song = "song"
        case elapsed = "elapsed"
        case remaining = "remaining"
    }
}
