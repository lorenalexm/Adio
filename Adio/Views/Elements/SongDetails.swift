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
                
                Text("\(formattedTime(from: songContainer.elapsed ?? 0)) / \(formattedTime(from: songContainer.duration))")
                    .font(.subheadline)
                    .foregroundColor(.text)
            }.padding(.horizontal, 40)
        }
    }
    
    // MARK: - Functions
    /// Takes a number of seconds, and formats it into "00:00" format. Ignores hours.
    /// - Parameter time: The seconds to parse.
    /// - Returns: A string with the formatted time.
    func formattedTime(from time: Int) -> String {
        let formatted = Int.formatFromSeconds(time)
        let minutes = String(format: "%02d", formatted.minutes)
        let seconds = String(format: "%02d", formatted.seconds)
        return "\(minutes):\(seconds)"
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
        container = SongContainer(shID: 1, playedAt: nil, duration: 256, playlist: "Default", streamer: nil, isRequest: nil, song: song, elapsed: 128, remaining: nil)
    }
}

struct SongDetails_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailsShell()
    }
}
