//
//  Score.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

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
