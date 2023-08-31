/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 26/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 File Manager in Swift: Reading, Writing, and Deleting Files and Directories: https://www.swiftyplace.com/blog/file-manager-in-swift-reading-writing-and-deleting-files-and-directories
 ios - How to check if a file exists in the Documents directory in Swift? - Stack Overflow: https://stackoverflow.com/questions/24181699/how-to-check-if-a-file-exists-in-the-documents-directory-in-swift
 How to load and save a struct in UserDefaults using Codable - free Swift 5.4 example code and tips: https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
 Finding sum of elements in Swift array - Stack Overflow: https://stackoverflow.com/questions/24795130/finding-sum-of-elements-in-swift-array
 */

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
                    let decoded = try decoder.decode(Leaderboard.self, from: data)
                    dict[difficulty.rawValue] = decoded
                } catch let error {
                    fatalError("Failed to decode JSON '\(fileName)': \(error)")
                }
            }
        }
    }
    
    return dict
}

func saveLeaderboardData(username: String, game: Game, difficulty: Difficulty) {
    // Create new leaderboard object
    let newTotal = leaderboardDict[difficulty.rawValue]!.total + 1
    var newWin = leaderboardDict[difficulty.rawValue]!.win
    var newScores = leaderboardDict[difficulty.rawValue]!.scores
    var newAchievement = leaderboardDict[difficulty.rawValue]!.achievements
    
    if (game.state == .win || game.state == .exit) {
        newWin += 1
    }
    
    if (game.state == .win) {
        let newScore = Score(username: username, score: game.moveLimit - game.moveCount + 1, gameNumber: leaderboardDict[difficulty.rawValue]!.total)
        
        // Add new score object to the array, sort array by score then gameNumber, delete the last bottom score object
        newScores.append(newScore)
        newScores.sort {
            if ($0.score == $1.score) {
                return $0.gameNumber > $1.gameNumber
            }
            return $0.score > $1.score
        }
        newScores.removeLast()
        
        // Update achievements
        newAchievement.append(.goodJob)
        if game.moveCount == Fleet.shipLengths.reduce(0, +) {
            newAchievement.append(.perfectGame)
        }
    }
    
    if (game.state == .lose) {
        newAchievement.append(.goodLuck)
    }
    
    let leaderboard = Leaderboard(total: newTotal, win: newWin, scores: newScores, achievements: newAchievement)
    
    // Write leaderboard to file
    let fileName = "\(difficulty.rawValue.lowercased()).json"
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let file = dir.appendingPathComponent(fileName)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(leaderboard) {
            do {
                try encoded.write(to: file)
            } catch let error {
                print("Failed to save \(difficulty.rawValue) Leaderboard Data: \(error)")
            }
        }
    }
}

// Delete Leaderboard Data from Settings

func deleteLeaderboardData() {
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
