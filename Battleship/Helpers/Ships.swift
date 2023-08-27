//
//  Ships.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import Foundation

struct Ships {
    static let shipLengths = [2, 3, 3, 4, 5]
    
    var ships: [Ship] = []
    
    mutating func deploy(on ocean: Ocean) -> Bool {
        ships.removeAll()
        for ship in Ships.shipLengths {
            let currentCoordinates = self.coordinates()
            let possibleLocations = ocean.possibleLocations(for: ship).filter { Set($0).intersection(currentCoordinates).isEmpty }
            guard (possibleLocations.count > 0) else {
                return false
            }
            
            let index = Int.random(in: 0..<possibleLocations.count)
            let shipLocation = possibleLocations[index]
            ships.append(Ship(location: shipLocation))
        }
        
        return true
    }
    
    func coordinates() -> [Coordinate] {
        let coordinates = ships.map { $0.parts.map { $0.coordinate } }
        return Array(coordinates.joined())
    }
}
