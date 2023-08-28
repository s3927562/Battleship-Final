//
//  Ship.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

class Ship {
    var parts: [ShipPart] = []
    var isSunk: Bool { !self.parts.contains(where: { !$0.isHit }) }
    
    init(coordinates: [Coordinate]) {
        for coordinate in coordinates {
            self.parts.append(ShipPart(location: coordinate))
        }
    }
    
    func occupy() -> [Coordinate] {
        return self.parts.map { $0.location }
    }
    
    func occupy(location: Coordinate) -> Bool {
        return self.parts.contains(where: { $0.location == location })
    }
    
    func hit(at location: Coordinate) {
        if let part = self.parts.first(where: { $0.location == location }) {
            part.isHit = true
        }
    }
}
