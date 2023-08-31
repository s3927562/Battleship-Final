//
//  GameState.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

//  GameState: Store the status of the current game
// Identifiable for win/lose sheet in GameView

enum GameState: Identifiable, Codable {
    case setup
    case lose
    case ongoing
    case win
    case exit
    
    var id: UUID { UUID() }
}
