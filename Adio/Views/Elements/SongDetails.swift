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
            if let artURL = songContainer.song.art {
                AsyncImage(url: URL(string: artURL), transaction: Transaction(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 32)
                            .frame(width: 250, height: 250)
                            .foregroundColor(.white)
                            .shadow(radius: 20)
                            .transition(.scale)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(32)
                            .shadow(radius: 20)
                            .transition(.scale)
                    default:
                        Text("Error fetching art!")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.text)
                    }
                }
            } else {
                Text("Error fetching art!")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.text)
            }
            
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
        SongDetails(songContainer: $container)
    }
    
    // MARK: - Functions.
    init(shouldArtFailToLoad: Bool = false) {
        song = Song(id: "1", text: nil, artist: "Upcoming artist", title: "The most awesome song", album: nil, genre: nil, isrc: nil, lyrics: nil, art: shouldArtFailToLoad ? nil : "https://picsum.photos/250", customFields: nil)
        container = SongContainer(shID: 1, playedAt: nil, duration: 256, playlist: "Default", streamer: nil, isRequest: nil, song: song, elapsed: 128, remaining: nil)
    }
}

struct SongDetails_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SongDetailsShell()
                .previewDisplayName("Art successfully fetched.")
            
            SongDetailsShell(shouldArtFailToLoad: true)
                .previewDisplayName("Art fetched failed.")
        }
    }
}
