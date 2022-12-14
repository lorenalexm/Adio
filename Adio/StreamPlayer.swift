//
//  StreamPlayer.swift
//  Adio
//
//  Created by Alex Loren on 12/13/22.
//

import SwiftAudioEx
import SwiftUI

public class StreamPlayer {
    // MARK: - Properties
    static let shared = StreamPlayer()
    let player = AudioPlayer()
    var audioItem: DefaultAudioItem?
    
    var isPlaying: Bool {
        get {
            return player.playerState == .paused
        }
    }
    
    // MARK: - Functions
    /// Configures the AudioPlayer object before playback.
    init() {
        player.bufferDuration = 3.0
    }
    
    /// Plays an audio stream from the given url stream.
    /// - Parameter url: The url to stream the audio from.
    func play(from url: String) {
        audioItem = DefaultAudioItem(audioUrl: url, sourceType: .stream)
        guard let audioItem else {
            print("Failed to create a DefaultAudioItem!")
            return
        }
        do {
            try player.load(item: audioItem, playWhenReady: false)
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
        let info = player.nowPlayingInfoController
        info.set(keyValues: [
            MediaItemProperty.artist(container.song.artist),
            MediaItemProperty.title(container.song.title),
            MediaItemProperty.albumTitle(container.song.album),
            MediaItemProperty.duration(Double(container.duration / 60)),
            NowPlayingInfoProperty.elapsedPlaybackTime(Double((container.elapsed ?? 0) / 60))
        ])
    }
}
