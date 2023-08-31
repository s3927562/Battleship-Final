//
//  ShipPart.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

//  ShipPart: A part of a Ship with Coordinate and hit status
//  'class' to mutate isHit

class ShipPart: Codable {
    let location: Coordinate
    var isHit = false
    
    init(location: Coordinate) {
        self.location = location
    }
}
