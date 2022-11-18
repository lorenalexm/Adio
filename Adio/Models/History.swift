//
//  History.swift
//  Adio
//
//  Created by Alex Loren on 11/18/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let history = try? newJSONDecoder().decode(History.self, from: jsonData)

import Foundation

// MARK: - HistoryElement
struct HistoryElement: Codable {
    let shID: Int?
    let playedAt: Int?
    let duration: Int?
    let playlist: String?
    let streamer: String?
    let isRequest: Bool?
    let song: HistoricSong?
    let listenersStart: Int?
    let listenersEnd: Int?
    let deltaTotal: Int?
    let isVisible: Bool?

    enum CodingKeys: String, CodingKey {
        case shID = "sh_id"
        case playedAt = "played_at"
        case duration = "duration"
        case playlist = "playlist"
        case streamer = "streamer"
        case isRequest = "is_request"
        case song = "song"
        case listenersStart = "listeners_start"
        case listenersEnd = "listeners_end"
        case deltaTotal = "delta_total"
        case isVisible = "is_visible"
    }
}

// MARK: - HistoricSong
struct HistoricSong: Codable {
    let id: String?
    let text: String?
    let artist: String?
    let title: String?
    let album: String?
    let genre: String?
    let isrc: String?
    let lyrics: String?
    let art: String?
    let customFields: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
        case artist = "artist"
        case title = "title"
        case album = "album"
        case genre = "genre"
        case isrc = "isrc"
        case lyrics = "lyrics"
        case art = "art"
        case customFields = "custom_fields"
    }
}

typealias History = [HistoryElement]
