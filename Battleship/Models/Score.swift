//
//  Score.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import Foundation

struct Score: Codable, Identifiable {
    let username: String
    let score: Int
    var id: UUID { UUID() }
}
