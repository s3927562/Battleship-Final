//
//  GameData.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 31/08/2023.
//

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
