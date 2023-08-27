//
//  Ship.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import Foundation

struct Ship {
    var parts: [ShipPart] = []
    var isSunk: Bool { !parts.contains(where: { !$0.isHit })}
    
    init(location: [Coordinate]) {
        self.parts = []
        for coordinate in location {
            parts.append(ShipPart(coordinate: coordinate))
        }
    }
}
