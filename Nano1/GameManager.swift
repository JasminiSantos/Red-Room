//
//  GameManager.swift
//  Nano 1
//
//  Created by Jasmini Rebecca Gomes dos Santos on 26/07/23.
//

import Foundation
import AVFoundation
import SwiftUI

enum SoundType {
    case background
    case audio1
    case audio2
    case audio3
    case audio4
    case audio5
    case reverse1
    case reverse2
    case reverse3
    case reverse4
    case reverse5
    case lockedBox
    case key
    case unlocked
    case wrongPassword
    case blackhole
}

class GameManager: ObservableObject {
    @Published var selectedScene = Scenes.menu
    private var audioPlayers: [SoundType: AVAudioPlayer] = [:]

    init() {
        prepareAudio()
    }

    func goToScene(_ scene: Scenes) {
        withAnimation (.easeInOut(duration: 2)) {
            selectedScene = scene
        }
    }

    private func prepareAudio() {
        prepareAudioPlayer(for: .background, fileName: "background", fileType: "mp3")
        prepareAudioPlayer(for: .audio1, fileName: "normal-01", fileType: "wav")
        prepareAudioPlayer(for: .audio2, fileName: "normal-02", fileType: "wav")
        prepareAudioPlayer(for: .audio3, fileName: "normal-03", fileType: "wav")
        prepareAudioPlayer(for: .audio4, fileName: "normal-04", fileType: "wav")
        prepareAudioPlayer(for: .audio5, fileName: "normal-05", fileType: "wav")
        
        prepareAudioPlayer(for: .reverse1, fileName: "reverse-01", fileType: "mp3")
        prepareAudioPlayer(for: .reverse2, fileName: "reverse-02", fileType: "mp3")
        prepareAudioPlayer(for: .reverse3, fileName: "reverse-03", fileType: "mp3")
        prepareAudioPlayer(for: .reverse4, fileName: "reverse-04", fileType: "mp3")
        prepareAudioPlayer(for: .reverse5, fileName: "reverse-05", fileType: "mp3")
        
        prepareAudioPlayer(for: .lockedBox, fileName: "locked-box", fileType: "wav")
        prepareAudioPlayer(for: .key, fileName: "key", fileType: "aiff")
        prepareAudioPlayer(for: .unlocked, fileName: "unlocked", fileType: "flac")
        prepareAudioPlayer(for: .wrongPassword, fileName: "wrong-password", fileType: "mp3")
        
        prepareAudioPlayer(for: .blackhole, fileName: "blackhole", fileType: "mp3")
    }

    private func prepareAudioPlayer(for soundType: SoundType, fileName: String, fileType: String) {
        guard let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("Could not find sound url for \(fileName).\(fileType)")
            return
        }

        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            if soundType == .background {
                audioPlayer.numberOfLoops = -1
            }
            else {
                audioPlayer.numberOfLoops = 0
            }
            audioPlayers[soundType] = audioPlayer
        } catch {
            print("Could not create audio player for \(fileName).\(fileType): \(error.localizedDescription)")
        }
    }

    func playSound(_ soundType: SoundType) {
        guard let audioPlayer = audioPlayers[soundType] else {
            print("Audio player for sound type \(soundType) not found.")
            return
        }
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }

    func stopSound(_ soundType: SoundType) {
        audioPlayers[soundType]?.stop()
    }
    
    func setVolume(for soundType: SoundType, volume: Float) {
        guard let audioPlayer = audioPlayers[soundType] else {
            print("Audio player for sound type \(soundType) not found.")
            return
        }

        audioPlayer.volume = volume
    }
    
    func lowerVolume(for soundType: SoundType, by decibels: Float) {
        guard let audioPlayer = audioPlayers[soundType] else {
            print("Audio player for sound type \(soundType) not found.")
            return
        }

        let currentVolume = audioPlayer.volume
        let newVolume = max(currentVolume - decibels, 0.0)
        audioPlayer.volume = newVolume
    }

    func resetVolume(for soundType: SoundType) {
        guard let audioPlayer = audioPlayers[soundType] else {
            print("Audio player for sound type \(soundType) not found.")
            return
        }

        audioPlayer.volume = 1.0
    }
    func getAudioDuration(for soundType: SoundType) -> TimeInterval? {
        guard let audioPlayer = audioPlayers[soundType] else {
            print("Audio player for sound type \(soundType) not found.")
            return nil
        }
        
        return audioPlayer.duration
    }
}

