//
//  Leaderboars.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//
//  https://stackoverflow.com/questions/34929932/round-up-double-to-2-decimal-places

import Foundation

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
    
    init() {
        self.total = 0
        self.win = 0
        self.scores = []
    }
}
