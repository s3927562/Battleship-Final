//
//  Ocean.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

struct Ocean {
    var rows = 8
    var columns = 8
    
    func possibleLocations(for shipLength: Int) -> [[Coordinate]] {
        var locations: [[Coordinate]] = []
        
        for y in 0..<rows {
            for shipBow in 0...(columns - shipLength) {
                var shipLocation: [Coordinate] = []
                for x in shipBow..<(shipBow + shipLength) {
                    shipLocation.append(Coordinate(x: x, y: y))
                }
                locations.append(shipLocation)
            }
        }
        
        for x in 0..<columns {
            for shipBow in 0...(rows - shipLength) {
                var shipLocation: [Coordinate] = []
                for y in shipBow..<(shipBow + shipLength) {
                    shipLocation.append(Coordinate(x: x, y: y))
                }
                locations.append(shipLocation)
            }
        }
        
        return locations
    }
}
