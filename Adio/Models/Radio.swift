//
//  Radio.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let radio = try? newJSONDecoder().decode(Radio.self, from: jsonData)

import Foundation

// MARK: - RadioElement
struct RadioElement: Codable {
    let station: Station?
    let listeners: Listeners?
    let live: Live?
    let nowPlaying: SongContainer?
    let playingNext: PlayingNext?
    let songHistory: [SongContainer]?
    let isOnline: Bool?

    enum CodingKeys: String, CodingKey {
        case station = "station"
        case listeners = "listeners"
        case live = "live"
        case nowPlaying = "now_playing"
        case playingNext = "playing_next"
        case songHistory = "song_history"
        case isOnline = "is_online"
    }
}

typealias Radio = [RadioElement]
