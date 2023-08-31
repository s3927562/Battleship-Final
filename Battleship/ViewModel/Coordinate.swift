//
//  Coordinate.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//
//  https://developer.apple.com/documentation/swift/set
//  https://github.com/apple/swift-evolution/blob/main/proposals/0185-synthesize-equatable-hashable.md
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/

import Foundation

//  Coordinate: (x, y) coordinate
//  Needs to be Hashable to convert Array(Coordinate) to Set(Coordinate) in Fleet.deploy(on ocean: Ocean)
//  and automatically synthesize conformance ('==' operator)

struct Coordinate: Hashable, Codable {
    let x: Int
    let y: Int
    
    // Default is (0, 0)
    init() {
        self.x = 0
        self.y = 0
    }
    
    // Remove argument labels
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
