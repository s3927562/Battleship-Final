/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 28/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import Foundation

struct Ocean: Codable {
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
