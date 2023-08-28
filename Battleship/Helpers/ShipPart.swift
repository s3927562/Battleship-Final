//
//  ShipPart.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

class ShipPart {
    var location = Coordinate()
    var isHit = false
    
    init(location: Coordinate) {
        self.location = location
    }
}
