//
//  Listeners.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import Foundation

// MARK: - Listeners
struct Listeners: Codable {
    let total: Int?
    let unique: Int?
    let current: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case unique = "unique"
        case current = "current"
    }
}
