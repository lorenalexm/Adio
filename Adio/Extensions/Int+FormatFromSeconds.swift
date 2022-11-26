//
//  Int+FormatFromSeconds.swift
//  Adio
//
//  Created by Alex Loren on 11/25/22.
//

import Foundation

extension Int {
    /// Takes in an `Int` as seconds and extracts hours, minutes, and seconds from that number.
    /// - Parameter seconds: The number from which to extract the time.
    /// - Returns: A tuple containing the values for hours, minutes, and seconds; in that order.
    func formatFromSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
