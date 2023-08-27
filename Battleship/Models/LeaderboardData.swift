//
//  LeaderboardData.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://stackoverflow.com/questions/24181699/how-to-check-if-a-file-exists-in-the-documents-directory-in-swift

import Foundation

var leaderboardDict: [String: Leaderboard] {
    var dict: [String: Leaderboard] = [:]
    for difficulty in difficultyDict.keys {
        let fileName = "\(difficulty.lowercased()).json"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = dir.appendingPathComponent(fileName)
            
            if !FileManager.default.fileExists(atPath: file.path) {
                if let defaultFile = Bundle.main.url(forResource: "default.json", withExtension: nil) {
                    do {
                        try FileManager.default.copyItem(at: defaultFile, to: file)
                    } catch let error {
                        fatalError("Failed to load JSON 'default.json': \(error)")
                    }
                }
            }
            
            if let data = try? Data(contentsOf: file) {
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode([Leaderboard].self, from: data)[0]
                    dict[difficulty] = decoded
                } catch let error {
                    fatalError("Failed to decode JSON '\(fileName)': \(error)")
                }
            }
        }
    }
    
    return dict
}
