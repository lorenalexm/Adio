//
//  SongDetails.swift
//  Adio
//
//  Created by Alex Loren on 11/25/22.
//

import SwiftUI

struct SongDetails: View {
    // MARK: - View declaration.
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 32)
                .frame(width: 250, height: 250)
                .foregroundColor(.white)
                .shadow(radius: 24)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Track name")
                        .font(.headline)
                        .foregroundColor(.text)
                    Text("Artist name")
                        .font(.subheadline)
                        .foregroundColor(.text)
                }.padding(.vertical)
                
                Spacer()
                
                Text("00:00 / 00:00")
                    .font(.subheadline)
                    .foregroundColor(.text)
            }.padding(.horizontal, 40)
        }
    }
}

struct SongDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            SongDetails()
        }
    }
}
