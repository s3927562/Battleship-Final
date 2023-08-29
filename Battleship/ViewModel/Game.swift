//
//  Game.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

//  Game: Contains a Fleet and an Ocean, keeping track of player move count, limit, and various status
//  'class' to mutate Fleet.ships[].parts[].isHit and oceanStates

//  TODO: Migrate oceanStates to Ocean (Nested ObservableObject?)

class Game: ObservableObject {
    var dimension = 8
    var fleet = Fleet()
    var ocean = Ocean()
    var moveCount = 0
    var moveLimit = Int.max
    @Published var oceanStates: [[OceanState]] = []
    @Published var state: GameState = .ongoing
    
    func start() {
        // Setup Ocean
        self.ocean = Ocean(dimension: self.dimension)
        
        // Deploy Fleet
        var isDeployed = false
        while (!isDeployed) {
            isDeployed = self.fleet.deploy(on: self.ocean)
        }
        
        // Initialize oceanStates
        for i in 0..<self.dimension {
            self.oceanStates.append([])
            for _ in 0..<self.dimension {
                self.oceanStates[i].append(.unknown)
            }
        }
    }
    
    func shoot(location: Coordinate) {
        // Do nothing if the location has already been shot
        if (oceanStates[location.x][location.y] != .unknown) {
            return
        }
        
        // Check if a ship has been shot
        if let ship = self.fleet.getShip(at: location) {
            // Update hit status of the corresponding ShipPart
            ship.hit(at: location)
            
            // Mark the corresponding oceanState
            if (ship.isSunk) {
                for location in ship.occupy() {
                    oceanStates[location.x][location.y] = .fullHit
                }
            } else {
                oceanStates[location.x][location.y] = .partialHit
            }
        } else {
            oceanStates[location.x][location.y] = .miss
        }
        
        // Update moveCount and game status
        moveCount += 1
        self.updateState()
    }
    
    // Check the current state of the game
    func updateState() {
        if (self.fleet.isDestroyed) {
            self.state = .win
        } else {
            self.state = .ongoing
        }
    }
}
