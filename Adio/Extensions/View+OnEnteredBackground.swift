//
//  View+OnEnteredBackground.swift
//  Adio
//
//  Created by Alex Loren on 12/20/22.
//

import SwiftUI

extension View {
    /// Respond to when the application enters the background state.
    /// - Parameter action: Callback to be used.
    func onEnteredBackground(perform action: @escaping () -> Void) -> some View {
        onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            action()
        }
    }
}
