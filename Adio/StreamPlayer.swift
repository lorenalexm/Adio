//
//  StreamPlayer.swift
//  Adio
//
//  Created by Alex Loren on 12/13/22.
//

import SwiftAudioEx
import SwiftUI
import MediaPlayer

public class StreamPlayer: ObservableObject {
    // MARK: - Properties
    static let shared = StreamPlayer()
    
    private let player = AudioPlayer()
    private let audioSession = AudioSessionController.shared
    private var audioItem: DefaultAudioItem?
    private var cachedContainer: SongContainer?
    private var cachedArtwork: UIImage?
    
    @Published var isPlaying = false
    
    // MARK: - Functions
    /// Configures the AudioPlayer object before playback.
    init() {
        do {
            try audioSession.set(category: .playback)
        } catch {
            print("Received the following error when setting playback category: \(error.localizedDescription)")
        }
        player.event.stateChange.addListener(self, handlePlayerStateChange)
        player.automaticallyUpdateNowPlayingInfo = true
        player.remoteCommands = [
            .togglePlayPause
        ]
    }
    
    /// Plays an audio stream from the given url stream.
    /// - Parameter url: The url to stream the audio from.
    func play(from url: String) {
        if !audioSession.audioSessionIsActive {
            do {
                try audioSession.activateSession()
            } catch {
                print("Received the following error when activating the audio session: \(error.localizedDescription)")
            }
        }
        
        audioItem = DefaultAudioItem(audioUrl: url, sourceType: .stream)
        guard let audioItem else {
            print("Failed to create a DefaultAudioItem!")
            return
        }
        do {
            try player.load(item: audioItem, playWhenReady: true)
        } catch {
            print("Received the following error when loading DefaultAudioItem: \(error.localizedDescription)")
        }
    }
    
    /// Pauses the current audio stream.
    func pause() {
        guard audioItem != nil else {
            print("DefaultAudioItem is nil, unable to pause the stream!")
            return
        }
        player.pause()
    }
    
    /// Updates the information of the currently playing song within the system and OS.
    /// - Parameter container: The `SongContainer` of the currently playing song.
    func updateNowPlaying(with container: SongContainer) {
        guard let artUrl = container.song.art else {
            print("No valid artwork URL!")
            return
        }
        
        if container.shID != cachedContainer?.shID {
            cachedContainer = container
            cachedArtwork = nil
        }
        updateMediaPropertyArtwork(with: URL(string: artUrl)!)
        
        player.nowPlayingInfoController.set(keyValues: [
            MediaItemProperty.artist(container.song.artist),
            MediaItemProperty.title(container.song.title),
            MediaItemProperty.albumTitle(container.song.album),
            MediaItemProperty.duration(Double(container.duration))
        ])
    }
    
    /// Listens for and handles changes in the `AudioPlayer` state.
    /// - Parameter state: The new state of the player.
    func handlePlayerStateChange(state: AudioPlayerState) {
        DispatchQueue.main.async { [unowned self] in
            switch state {
            case .playing:
                self.isPlaying = true
            case .paused:
                self.isPlaying = false
            default:
                return
            }
        }
    }
    
    /// Attempts to fetch an image from a remote source.
    /// - Parameter url: Where should the image be fetched from?
    func updateMediaPropertyArtwork(with url: URL) {
        if cachedArtwork == nil {
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    cachedArtwork = UIImage(data: data)
                } catch {
                    print("Could not fetch image from remote server, error of: \(error.localizedDescription)")
                }
            }
        }
        
        guard let cachedArtwork else {
            print("Artwork has yet to be cached!")
            return
        }
        
        let artwork = MPMediaItemArtwork(boundsSize: cachedArtwork.size, requestHandler: { (size) -> UIImage in
            return cachedArtwork
        })
        let info = player.nowPlayingInfoController
        info.set(keyValues: [
            MediaItemProperty.artwork(artwork)
        ])
    }
}
