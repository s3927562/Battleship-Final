//
//  Coordinate.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

struct Coordinate: Hashable {
    var x = 0
    var y = 0
    
    static func == (leftCoordinate: Coordinate, rightCoordinate: Coordinate) -> Bool {
        return (leftCoordinate.x == rightCoordinate.x) && (leftCoordinate.y == rightCoordinate.y)
    }
}
