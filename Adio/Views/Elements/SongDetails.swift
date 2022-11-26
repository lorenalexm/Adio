//
//  SongDetails.swift
//  Adio
//
//  Created by Alex Loren on 11/25/22.
//

import SwiftUI

struct SongDetails: View {
    // MARK: - Properties.
    @Binding var songContainer: SongContainer
    
    // MARK: - View declaration.
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 32)
                .frame(width: 250, height: 250)
                .foregroundColor(.white)
                .shadow(radius: 24)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(songContainer.song.title)
                        .font(.headline)
                        .foregroundColor(.text)
                    Text(songContainer.song.artist)
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

// MARK: - Preview building.
struct SongDetailsShell: View {
    // MARK: - Properties.
    private var song: Song
    @State var container: SongContainer
    
    // MARK: - View declaration.
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            SongDetails(songContainer: $container)
        }
    }
    
    // MARK: - Functions.
    init() {
        song = Song(id: "1", text: nil, artist: "Upcoming artist", title: "The most awesome song", album: nil, genre: nil, isrc: nil, lyrics: nil, art: nil, customFields: nil)
        container = SongContainer(shID: 1, playedAt: nil, duration: 600, playlist: "Default", streamer: nil, isRequest: nil, song: song, elapsed: nil, remaining: nil)
    }
}

struct SongDetails_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailsShell()
    }
}
