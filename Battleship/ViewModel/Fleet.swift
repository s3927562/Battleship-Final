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
 Battleship (game) - Wikipedia: https://en.wikipedia.org/wiki/Battleship_(game)
 Set | Apple Developer Documentation: https://developer.apple.com/documentation/swift/set
 map(_:) | Apple Developer Documentation: https://developer.apple.com/documentation/swift/array/map(_:)-87c4d
 joined(separator:) | Apple Developer Documentation: https://developer.apple.com/documentation/swift/array/joined(separator:)-7uber
 first(where:) | Apple Developer Documentation: https://developer.apple.com/documentation/swift/array/first(where:)
 */

import Foundation

//  Fleet: Collection of Ships
//  'class' to mutate ships[].parts[].isHit

class Fleet: Codable {
    // All fleets in Battleship have the same ships
    static let shipLengths = [2, 3, 3, 4, 5]
    var ships: [Ship] = []
    var isDestroyed: Bool {
        // Fleet is destroyed when all Ships are sunk
        !self.ships.contains(where: { !$0.isSunk })
    }
    
    func deploy(on ocean: Ocean) -> Bool {
        // If there is a previous game, need to remove all Ships
        self.ships.removeAll()
        for shipLength in Fleet.shipLengths {
            // Find all locations that can fit a Ship of certain length without intersecting any other Ships
            // i.e., the array of intersections is empty
            let fleetCoordinates = self.occupy()
            let possibleLocationsWithIntersect = ocean.possibleLocations(for: shipLength)
            let possibleLocations = possibleLocationsWithIntersect.filter { Set($0).intersection(fleetCoordinates).isEmpty }
            
            // In case there is no way to fit a ship, return to Game for redeployment
            guard (possibleLocations.count > 0) else {
                return false
            }
            
            // Randomly choose a position to initialize a Ship then add to Fleet
            let index = Int.random(in: 0..<possibleLocations.count)
            let shipLocation = possibleLocations[index]
            let ship = Ship(coordinates: shipLocation)
            self.ships.append(ship)
        }
        
        return true
    }
    
    // Obtain all Coordinates the Ship occupy
    func occupy() -> [Coordinate] {
        let coordinates = self.ships.map { $0.occupy() }
        return Array(coordinates.joined())
    }
    
    // Return an Optional(Ship) that occupies a Coordinate if there is one, nil if none
    func getShip(at location: Coordinate) -> Ship? {
        return self.ships.first(where: { $0.occupy(location: location) })
    }
}
