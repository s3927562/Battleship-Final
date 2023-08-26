//
//  LeaderboardData.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//

import Foundation

struct Score: Codable, Identifiable {
    let username: String
    let score: Int
    var id: UUID { UUID() }
}

struct Leaderboard: Codable {
    var total: Int
    var win: Int
    var winPercentage: String {
        if total > 0 {
            return String(format: "%.2f", Double(win) / Double(total) * 100)
        }
        
        return "0.00"
    }
    
    var scores: [Score]
}

let difficulties = ["Easy": 0, "Medium": 1, "Hard": 2]

var leaderboardDict: [String: Leaderboard] {
    var dict: [String: Leaderboard] = [:]
    for difficulty in difficulties.keys {
        
        // Try to load normal data
        var loaded = false
        let fileName = "\(difficulty.lowercased()).json"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = dir.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: file.path) {
                let data = try! Data(contentsOf: file)
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode([Leaderboard].self, from: data)[0]
                    dict[difficulty] = decoded
                    loaded = true
                } catch let error {
                    fatalError("Failed to decode JSON '\(fileName)': \(error)")
                }
            }
        }
        
        // Load default data if fail
        if !loaded {
            if let file = Bundle.main.url(forResource: "default.json", withExtension: nil) {
                if let data = try? Data(contentsOf: file) {
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode([Leaderboard].self, from: data)[0]
                        dict[difficulty] = decoded
                    } catch let error {
                        fatalError("Failed to decode JSON 'default.json': \(error)")
                    }
                }
            } else {
                fatalError("Couldn't load default data")
            }
        }
    }
    
    return dict
}
