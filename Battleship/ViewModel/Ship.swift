/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 28/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 map(_:) | Apple Developer Documentation: https://developer.apple.com/documentation/swift/array/map(_:)-87c4d
 contains(_:) | Apple Developer Documentation: https://developer.apple.com/documentation/swift/array/contains(_:)
 first(where:) | Apple Developer Documentation: https://developer.apple.com/documentation/swift/array/first(where:)
 */

import Foundation

//  Ship: Collection of ShipParts
//  'class' to mutate parts[].isHit

class Ship: Codable {
    var parts: [ShipPart] = []
    var isSunk: Bool {
        // The Ship will be sunk if all ShipParts are hit
        !self.parts.contains(where: { !$0.isHit })
    }
    
    // Initializer: Using Coordinates to initialize ShipParts then append to the Ship
    init(coordinates: [Coordinate]) {
        for coordinate in coordinates {
            self.parts.append(ShipPart(location: coordinate))
        }
    }
    
    // Obtain all Coordinates the Ship occupy
    func occupy() -> [Coordinate] {
        return self.parts.map { $0.location }
    }
    
    // Check if the Ship has a ShipPart that occupy a certain Coordinate
    func occupy(location: Coordinate) -> Bool {
        return self.parts.contains(where: { $0.location == location })
    }
    
    // Change hit status of ShipPart at a Coordinate to true
    func hit(at location: Coordinate) {
        if let part = self.parts.first(where: { $0.location == location }) {
            part.isHit = true
        }
    }
}
