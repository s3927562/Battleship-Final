/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 31/08/2023
 Last modified: 05/09/2023
 Acknowledgement:
    RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
    AVAudioPlayer | Apple Developer Documentation: https://developer.apple.com/documentation/avfaudio/avaudioplayer
 */

import Foundation
import AVFoundation

enum AudioPlayer {
    case SFX
    case BGM
}

var SFXAudioPlayer: AVAudioPlayer?
var BGMAudioPlayer: AVAudioPlayer?

func playBGM() {
    if let path = Bundle.main.path(forResource: "mainLoop", ofType: "aiff") {
        do {
            BGMAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path), fileTypeHint: "aiff")
            
            // Infinite loop
            BGMAudioPlayer?.numberOfLoops = -1
            
            // Make music fade in
            BGMAudioPlayer?.volume = 0
            BGMAudioPlayer?.play()
            BGMAudioPlayer?.setVolume(Float(UserDefaults.standard.double(forKey: "volumeBGM") / 100), fadeDuration: 0.5)
        } catch {
            print("Failed to play mainLoop.mp3")
        }
    }
}

func playSFX(_ sound: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: "mp3") {
        do {
            SFXAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path), fileTypeHint: "mp3")
            SFXAudioPlayer?.volume = Float(UserDefaults.standard.double(forKey: "volumeSFX") / 100)
            SFXAudioPlayer?.play()
        } catch {
            print("Failed to play \(sound).mp3")
        }
    }
}

func changeVolume(to volume: Float, type: AudioPlayer) {
    if (type == .SFX) {
        SFXAudioPlayer?.volume = volume / 100
    } else if (type == .BGM) {
        BGMAudioPlayer?.volume = volume / 100
    }
}
