//
//  Station.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - Station
struct Station: Codable {
    let id: Int?
    let name: String?
    let shortcode: String?
    let stationDescription: String?
    let frontend: String?
    let backend: String?
    let listenURL: String?
    let url: String?
    let publicPlayerURL: String?
    let playlistPlsURL: String?
    let playlistM3UURL: String?
    let isPublic: Bool?
    let mounts: [Mount]?
    let remotes: [String]?
    let hlsEnabled: Bool?
    let hlsURL: String?
    let hlsListeners: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shortcode = "shortcode"
        case stationDescription = "description"
        case frontend = "frontend"
        case backend = "backend"
        case listenURL = "listen_url"
        case url = "url"
        case publicPlayerURL = "public_player_url"
        case playlistPlsURL = "playlist_pls_url"
        case playlistM3UURL = "playlist_m3u_url"
        case isPublic = "is_public"
        case mounts = "mounts"
        case remotes = "remotes"
        case hlsEnabled = "hls_enabled"
        case hlsURL = "hls_url"
        case hlsListeners = "hls_listeners"
    }
}
