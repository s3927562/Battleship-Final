/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 31/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 How to load and save a struct in UserDefaults using Codable - free Swift 5.4 example code and tips: https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
 */

import Foundation

// Read and write game data to UserDefaults

func saveGameData(for game: Game) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(game) {
        UserDefaults.standard.set(encoded, forKey: "GameSave")
    }
}

func readGameData() -> Game? {
    if let savedGame = UserDefaults.standard.object(forKey: "GameSave") as? Data {
        let decoder = JSONDecoder()
        if let loadedGame = try? decoder.decode(Game.self, from: savedGame) {
            return loadedGame
        }
    }
    return nil
}
