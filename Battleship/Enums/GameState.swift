//
//  GameState.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

enum GameState: Identifiable {
    case lose
    case ongoing
    case win
    
    var id: UUID { UUID() }
}
