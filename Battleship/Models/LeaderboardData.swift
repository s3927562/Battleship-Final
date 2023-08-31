//
//  LeaderboardData.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://www.swiftyplace.com/blog/file-manager-in-swift-reading-writing-and-deleting-files-and-directories
//  https://stackoverflow.com/questions/24181699/how-to-check-if-a-file-exists-in-the-documents-directory-in-swift

import Foundation

//  Loading leaderboard data files into dictionaries

var leaderboardDict: [String: Leaderboard] {
    var dict: [String: Leaderboard] = [:]
    
    for difficulty in Difficulty.allCases {
        // Get path to leaderboard data file
        let fileName = "\(difficulty.rawValue.lowercased()).json"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = dir.appendingPathComponent(fileName)
            
            // Copy default leaderboard data if leaderboard data file doesn't exist
            if (!FileManager.default.fileExists(atPath: file.path)) {
                if let defaultFile = Bundle.main.url(forResource: "default.json", withExtension: nil) {
                    do {
                        try FileManager.default.copyItem(at: defaultFile, to: file)
                    } catch let error {
                        fatalError("Failed to load JSON 'default.json': \(error)")
                    }
                }
            }
            
            // Read from leaderboard data file
            if let data = try? Data(contentsOf: file) {
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode([Leaderboard].self, from: data)[0]
                    dict[difficulty.rawValue] = decoded
                } catch let error {
                    fatalError("Failed to decode JSON '\(fileName)': \(error)")
                }
            }
        }
    }
    
    return dict
}

// Delete Leaderboard Data from Settings

func deleteLeaderboardData () {
    for difficulty in Difficulty.allCases {
        let fileName = "\(difficulty.rawValue.lowercased()).json"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = dir.appendingPathComponent(fileName)
            if FileManager.default.fileExists(atPath: file.path) {
                do {
                    try FileManager.default.removeItem(at: file)
                } catch let error {
                    print(error)
                }
            }
        }
    }
}
