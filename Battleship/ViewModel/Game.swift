//
//  Game.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//
//  https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties

import Foundation

//  Game: Contains a Fleet and an Ocean, keeping track of player move count, limit, and various status
//  'class' to mutate Fleet.ships[].parts[].isHit and oceanStates

//  TODO: Migrate oceanStates to Ocean (Nested ObservableObject?)

class Game: ObservableObject, Codable {
    var dimension: Int
    var fleet: Fleet
    var ocean: Ocean
    var moveCount: Int
    var moveLimit: Int
    @Published var oceanStates: [[OceanState]]
    @Published var state: GameState
    
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
        
        self.state = .ongoing
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
        } else if (moveCount >= moveLimit) {
            self.state = .lose
        } else {
            self.state = .ongoing
        }
    }
    
    // Default initializer
    init() {
        self.dimension = 0
        self.fleet = Fleet()
        self.ocean = Ocean()
        self.moveCount = 0
        self.moveLimit = Int.max
        self.oceanStates = []
        self.state = .setup
    }
    
    // Conforming Game to Codable since @Published objects do not conform to Codable
    enum CodingKeys: CodingKey {
        case dimension
        case fleet
        case ocean
        case moveCount
        case moveLimit
        case oceanStates
        case state
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dimension = try container.decode(Int.self, forKey: .dimension)
        fleet = try container.decode(Fleet.self, forKey: .fleet)
        ocean = try container.decode(Ocean.self, forKey: .ocean)
        moveCount = try container.decode(Int.self, forKey: .moveCount)
        moveLimit = try container.decode(Int.self, forKey: .moveLimit)
        oceanStates = try container.decode([[OceanState]].self, forKey: .oceanStates)
        state = try container.decode(GameState.self, forKey: .state)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dimension, forKey: .dimension)
        try container.encode(fleet, forKey: .fleet)
        try container.encode(ocean, forKey: .ocean)
        try container.encode(moveCount, forKey: .moveCount)
        try container.encode(moveLimit, forKey: .moveLimit)
        try container.encode(oceanStates.self, forKey: .oceanStates)
        try container.encode(state.self, forKey: .state)
    }
}
