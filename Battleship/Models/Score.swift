/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 27/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import Foundation

// Score: Keep track of score for different players
// gameNumber is used for sorting leaderboard
// id is used for displaying in LeaderboardSheet

struct Score: Codable, Identifiable {
    let username: String
    let score: Int
    let gameNumber: Int
    var id: UUID { UUID() }
}
