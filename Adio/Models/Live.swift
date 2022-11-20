//
//  Live.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - Live
struct Live: Codable {
    let isLive: Bool?
    let streamerName: String?
    let broadcastStart: Int?
    let art: String?

    enum CodingKeys: String, CodingKey {
        case isLive = "is_live"
        case streamerName = "streamer_name"
        case broadcastStart = "broadcast_start"
        case art = "art"
    }
}
