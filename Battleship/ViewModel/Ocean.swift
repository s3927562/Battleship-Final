//
//  Ocean.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

struct Ocean {
    var dimension = 0
    
    // Find all places that a Ship of a certain length can fit
    // Each place is an array of Coordinates for the Ship
    func possibleLocations(for shipLength: Int) -> [[Coordinate]] {
        var locations: [[Coordinate]] = []
        
        // Horizontal fit
        for y in 0..<self.dimension {
            for shipBow in 0...(self.dimension - shipLength) {
                var shipLocation: [Coordinate] = []
                for x in shipBow..<(shipBow + shipLength) {
                    shipLocation.append(Coordinate(x, y))
                }
                locations.append(shipLocation)
            }
        }
        
        // Vertical fit
        for x in 0..<self.dimension {
            for shipBow in 0...(self.dimension - shipLength) {
                var shipLocation: [Coordinate] = []
                for y in shipBow..<(shipBow + shipLength) {
                    shipLocation.append(Coordinate(x, y))
                }
                locations.append(shipLocation)
            }
        }
        
        return locations
    }
}
