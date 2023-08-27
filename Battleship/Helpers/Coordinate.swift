//
//  Coordinate.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import Foundation

struct Coordinate: Hashable {
    var x: Int
    var y: Int
    
    init(_ x: Int = 0, _ y: Int = 0) {
        self.x = x
        self.y = y
    }
    
    static func == (c1: Coordinate, c2: Coordinate) -> Bool {
        return (c1.x == c2.x) && (c1.y == c2.y)
    }
}
