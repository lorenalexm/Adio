//
//  RecentlyPlayedView.swift
//  Adio
//
//  Created by Alex Loren on 11/19/22.
//

import SwiftUI

struct RecentlyPlayedView: View {
    var body: some View {
        GradientBackground {
            List(0...15, id: \.self) {
                Text("Artist \($0)")
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct RecentlyPlayedView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyPlayedView()
    }
}
