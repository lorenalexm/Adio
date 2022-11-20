//
//  Mount.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - Mount
struct Mount: Codable {
    let id: Int?
    let name: String?
    let url: String?
    let bitrate: Int?
    let format: String?
    let listeners: Listeners?
    let path: String?
    let isDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
        case bitrate = "bitrate"
        case format = "format"
        case listeners = "listeners"
        case path = "path"
        case isDefault = "is_default"
    }
}
