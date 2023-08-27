//
//  Ocean.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import Foundation

struct Ocean {
    var rows: Int
    var columns: Int
    
    init(_ rows: Int, _ columns: Int) {
        self.rows = rows
        self.columns = columns
    }
    
    func possibleLocations(for length: Int) -> [[Coordinate]] {
        var locations: [[Coordinate]] = []
        
        // Horizontal fits
        for y in 0..<rows {
            for head in 0...(columns - length) {
                var location: [Coordinate] = []
                for x in head..<(head + length) {
                    location.append(Coordinate(x, y))
                }
                locations.append(location)
            }
        }
        
        // Vertical fits
        for x in 0..<columns {
            for head in 0...(rows - length) {
                var location: [Coordinate] = []
                for y in head...(head + length) {
                    location.append(Coordinate(x, y))
                }
                locations.append(location)
            }
        }
        
        return locations
    }
}
