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
    private var timer: Timer?
    
    @Published var radioUrl: String?
    @Published var nowPlaying: SongContainer?
    @Published var nowPlayingArt: UIImage?
    @Published var nowPlayingArtColor: Color?
    @Published var recentlyPlayed: [SongContainer]?
    @Published var elapsedTime: Int = 0
    
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
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: tick)
            
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
            updateProperties(from: radioDetails)
            syncElapsedTime(with: radioDetails.nowPlaying?.elapsed ?? 0)
            fetchNowPlayingArt()
            
            if let nowPlaying {
                StreamPlayer.shared.updateNowPlaying(with: nowPlaying)
            }
            
        case .error(let error):
            connected = false
            print("Received error from remote socket server! \n\(error!.localizedDescription)")
            
        default:
            break
        }
    }
    
    /// Syncs the elapsed time to the time received from the remote server.
    /// - Parameter time: Which time should `elapsedTime` be synced to.
    func syncElapsedTime(with time: Int) {
        if elapsedTime != time {
            elapsedTime = time
        }
    }
    
    /// Attempts to fetch the album art of the song now playing.
    /// Calculates and stores the average color of the art.
    func fetchNowPlayingArt() {
        guard let nowPlaying,
        let recentlyPlayed,
        nowPlaying.shID != recentlyPlayed[0].shID,
        let artUrl = nowPlaying.song.art else {
            print("First guard")
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: artUrl)!) { [unowned self] (data, response, error) in
            guard error == nil else {
                print("Failed to fetch now playing art!")
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                print("Did not receive a valid response from the remote server!")
                return
            }
            
            guard let data else {
                print("Image data received was not valid!")
                return
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.nowPlayingArt = UIImage(data: data)
                self.nowPlayingArtColor = nowPlayingArt?.averageColor
            }
        }
        
        task.resume()
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
    
    /// Updates the class properties from the current `RadioElement`.
    /// - Parameter radio: The current radio information from the remote server.
    func updateProperties(from radio: RadioElement) {
        guard let mounts = radio.station?.mounts else {
            print("Unable to find a valid station mount!")
            return
        }
        
        radioUrl = mounts[0].url
        nowPlaying = radio.nowPlaying
        recentlyPlayed = radio.songHistory
    }
    
    /// Increments the `Song` elapsed time.
    /// - Parameter timer: The `Timer` object running the tick.
    func tick(_ timer: Timer) {
        guard connected == true else {
            self.timer?.invalidate()
            self.timer = nil
            return
        }
        elapsedTime += 1
    }
}
