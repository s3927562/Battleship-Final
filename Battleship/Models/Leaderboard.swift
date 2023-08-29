//
//  Leaderboars.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//
//  https://stackoverflow.com/questions/34929932/round-up-double-to-2-decimal-places

import Foundation

// Leaderboard: Keep track of games played, game won, and top scores

struct Leaderboard: Codable {
    var total = 0
    var win = 0
    var winPercentage: String {
        if total > 0 {
            return String(format: "%.2f", Double(win) / Double(total) * 100)
        }
        
        return "0.00"
    }
    var scores: [Score] = []
}
