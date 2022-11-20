//
//  Song.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - Song
struct Song: Codable {
    let id: String
    let text: String?
    let artist: String
    let title: String
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
