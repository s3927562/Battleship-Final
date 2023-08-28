//
//  Game.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

class Game: ObservableObject {
    var rows = 8
    var columns = 8
    var fleet = Fleet()
    var ocean = Ocean()
    var moves = 0
    @Published var oceanStates: [[OceanState]] = []
    @Published var state: GameState = .ongoing
    
    func start() {
        self.ocean = Ocean(rows: self.rows, columns: self.columns)
        
        var isDeployed = false
        while (!isDeployed) {
            isDeployed = self.fleet.deploy(on: self.ocean)
        }
        
        for i in 0..<self.columns {
            self.oceanStates.append([])
            for _ in 0..<self.rows {
                self.oceanStates[i].append(.unknown)
            }
        }
    }
    
    func shoot(location: Coordinate) {
        if (oceanStates[location.x][location.y] != .unknown) {
            return
        }
        
        if let ship = fleet.getShip(at: location) {
            ship.hit(at: location)
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
        
        moves += 1
        self.currentState()
    }
    
    func currentState() {
        if (self.fleet.isDestroyed) {
            self.state = .win
        } else {
            self.state = .ongoing
        }
    }
}
