/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 28/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import Foundation

// Leaderboard: Keep track of games played, game won, and top scores
// If an achievement is achieved, it will be added to the achievement array

struct Leaderboard: Codable {
    var total = 0
    var win = 0
    var winPercentage: String {
        if (total > 0) {
            return String(format: "%.2f", Double(win) / Double(total) * 100)
        }
        
        return "0.00"
    }
    var scores: [Score] = []
    var achievements: [Achievement] = []
}
