//
//  Fleet.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

class Fleet {
    static let shipLengths = [2, 3, 3, 4, 5]
    var ships: [Ship] = []
    var isDestroyed: Bool { !self.ships.contains(where: { !$0.isSunk }) }
    
    func deploy(on ocean: Ocean) -> Bool {
        self.ships.removeAll()
        for shipLength in Fleet.shipLengths {
            let fleetCoordinates = self.occupy()
            let possibleLocationsWithIntersect = ocean.possibleLocations(for: shipLength)
            let possibleLocations = possibleLocationsWithIntersect.filter { Set($0).intersection(fleetCoordinates).isEmpty }
            guard (possibleLocations.count > 0) else {
                return false
            }
            
            let index = Int.random(in: 0..<possibleLocations.count)
            let shipLocation = possibleLocations[index]
            let ship = Ship(coordinates: shipLocation)
            ships.append(ship)
        }
        
        return true
    }
    
    func occupy() -> [Coordinate] {
        let coordinates = self.ships.map { $0.occupy() }
        return Array(coordinates.joined())
    }
    
    func getShip(at location: Coordinate) -> Ship? {
        return ships.first(where: { $0.occupy(location: location) })
    }
}
