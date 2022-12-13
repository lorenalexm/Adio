//
//  Text+ForegroundLinearGradient.swift
//  Adio
//
//  Created by Alex Loren on 12/12/22.
//

import SwiftUI

extension Text {
    /// Creates a new gradient overlay across the view.
    /// - Parameters:
    ///   - colors: An array of `Color` values to be used for the gradient.
    ///   - startingAt: What point the gradient begins at.
    ///   - endingAt: Where the gradient end.
    /// - Returns: A gradient overlay over the view.
    public func foregroundLinearGradient(colors: [Color], startingAt: UnitPoint, endingAt: UnitPoint) -> some View {
        return self.overlay {
            LinearGradient(colors: colors, startPoint: startingAt, endPoint: endingAt)
                .mask(self)
        }
    }
}
