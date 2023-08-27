//
//  Difficulty.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import Foundation

struct Difficulty {
    let id: Int
    let description: String
}

let difficultyDict: [String: Difficulty] = [
    "Easy": Difficulty(id: 0, description: "Easy Description"),
    "Medium": Difficulty(id: 1, description: "Medium Description"),
    "Hard": Difficulty(id: 2, description: "Hard Description")
]
