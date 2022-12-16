//
//  SongDetails.swift
//  Adio
//
//  Created by Alex Loren on 11/25/22.
//

import SwiftUI

struct SongDetails: View {
    // MARK: - Properties.
    @EnvironmentObject private var socketClient: SocketClient
    
    // MARK: - View declaration.
    var body: some View {
        VStack {
            if let artURL = socketClient.nowPlaying?.song.art {
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
                    Text(socketClient.nowPlaying?.song.title ?? "No title")
                        .font(.headline)
                        .foregroundColor(.text)
                    Text(socketClient.nowPlaying?.song.artist ?? "No artist")
                        .font(.subheadline)
                        .foregroundColor(.text)
                }.padding(.vertical)
                
                Spacer()
                
                Text("\(formattedTime(from: socketClient.elapsedTime)) / \(formattedTime(from: socketClient.nowPlaying?.duration ?? 0))")
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

struct SongDetails_Previews: PreviewProvider {
    // MARK: - Properties.
    static var socketClient = SocketClient()
    
    static var previews: some View {
        SongDetails()
            .environmentObject(socketClient)
    }
}
