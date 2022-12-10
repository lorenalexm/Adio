//
//  Player.swift
//  Adio
//
//  Created by Alex Loren on 12/9/22.
//

import SwiftUI
import Starscream

class Player: ObservableObject, WebSocketDelegate {
    // MARK: - Properties.
    private let socket: WebSocket
    private let decoder = JSONDecoder()
    private var connected = false
    private var radioDetails: Radio?
    
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
            radioDetails = try? decoder.decode(Radio.self, from: message.data(using: .utf8)!)
            nowPlaying = radioDetails?[0].nowPlaying
            recentlyPlayed = radioDetails?[0].songHistory
        case .error(let error):
            connected = false
            print("Received error from remote socket server! \n\(error!.localizedDescription)")
        default:
            break
        }
    }
}
