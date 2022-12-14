//
//  StreamPlayer.swift
//  Adio
//
//  Created by Alex Loren on 12/13/22.
//

import SwiftAudioEx
import SwiftUI

public class StreamPlayer: ObservableObject {
    // MARK: - Properties
    static let shared = StreamPlayer()
    
    let player = AudioPlayer()
    let audioSession = AudioSessionController.shared
    var audioItem: DefaultAudioItem?
    
    @Published var isPlaying = false
    
    // MARK: - Functions
    /// Configures the AudioPlayer object before playback.
    init() {
        do {
            try audioSession.set(category: .playback)
        } catch {
            print("Received the following error when setting playback category: \(error.localizedDescription)")
        }
        player.automaticallyWaitsToMinimizeStalling = false
        player.bufferDuration = 3.0
        player.event.stateChange.addListener(self, handlePlayerStateChange)
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
        let info = player.nowPlayingInfoController
        info.set(keyValues: [
            MediaItemProperty.artist(container.song.artist),
            MediaItemProperty.title(container.song.title),
            MediaItemProperty.albumTitle(container.song.album),
            MediaItemProperty.duration(Double(container.duration / 60)),
            NowPlayingInfoProperty.elapsedPlaybackTime(Double((container.elapsed ?? 0) / 60))
        ])
    }
    
    /// Listens for and handles changes in the `AudioPlayer` state.
    /// - Parameter state: The new state of the player.
    func handlePlayerStateChange(state: AudioPlayerState) {
        switch state {
        case .playing:
            isPlaying = true
        case .paused:
            isPlaying = false
        default:
            return
        }
    }
}
