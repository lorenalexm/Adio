//
//  SocketClient.swift
//  Adio
//
//  Created by Alex Loren on 12/9/22.
//

import SwiftUI
import Starscream

class SocketClient: ObservableObject, WebSocketDelegate {
    // MARK: - Properties.
    private let socket: WebSocket
    private let decoder = JSONDecoder()
    private var connected = false
    private var radioDetails: RadioElement?
    
    @Published var nowPlaying: SongContainer?
    @Published var recentlyPlayed: [SongContainer]?    
    
    // MARK: - Functions.
    /// Initializes the `WebSocket` object and sets delegate function.
    init() {
        var request = URLRequest(url: URL(string: "https://radio.alexloren.com/api/live/nowplaying/lofi")!)
        request.timeoutInterval = 3
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    /// Delegate for the `WebSocket`.
    /// - Parameters:
    ///   - event: Events received from the remote socket server.
    ///   - client: The current client
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            connected = true
        case .disconnected(_, _):
            connected = false
        case .text(let message):
            print("Received data message from remote socket server.")
            let sanitized = sanitizeUnicodeEmoji(from: message)
            guard let sanitized else {
                print("Unable to sanitize JSON string!")
                return
            }
            
            radioDetails = try? decoder.decode(RadioElement.self, from: sanitized.data(using: .utf8)!)
            guard let radioDetails else {
                print("Unable to decode message from remote socket server!")
                return
            }
            nowPlaying = radioDetails.nowPlaying
            recentlyPlayed = radioDetails.songHistory
        case .error(let error):
            connected = false
            print("Received error from remote socket server! \n\(error!.localizedDescription)")
        default:
            break
        }
    }
    
    
    /// Attempts to sanatize a JSON `String` by escaping unicode characters.
    /// - Parameter unsanitized: The JSON `String` to be sanatized.
    /// - Returns: A new string with properly escaped unicode characters.
    func sanitizeUnicodeEmoji(from unsanitized: String) -> String? {
        let regex = try? NSRegularExpression(pattern: #"\\u[0-9a-fA-F]{4}"#)
        guard let regex else {
            print("Unable to create regex!")
            return nil
        }
        
        let matches = regex.matches(in: unsanitized, range: NSMakeRange(0, unsanitized.count))
        let mutableString = NSMutableString(string: unsanitized)

        matches.reversed().forEach { match in
            guard let range = Range(match.range, in: unsanitized) else {
                return
            }
            let matchedString = String(unsanitized[range])

            let replacement = "\\\(matchedString)"
            //replacement.insert("{", at: replacement.index(replacement.startIndex, offsetBy: 3))
            //replacement.insert("}", at: replacement.endIndex)
            
            regex.replaceMatches(in: mutableString, options: [], range: match.range, withTemplate: replacement)
        }
        return String(mutableString)
    }
}