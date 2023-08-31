/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 31/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import Foundation

import AVFoundation

var SFXAudioPlayer: AVAudioPlayer?

func playSFX(_ sound: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: ".mp3") {
        do {
            SFXAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path), fileTypeHint: "mp3")
            SFXAudioPlayer?.volume = Float(UserDefaults.standard.double(forKey: "volume") / 100)
            SFXAudioPlayer?.play()
        } catch {
            print("Failed to play \(sound).mp3")
        }
    }
}
