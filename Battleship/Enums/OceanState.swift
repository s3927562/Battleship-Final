//
//  OceanStates.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import Foundation

//  OceanState: Store the state of one block on the Ocean

enum OceanState: Codable {
    case miss
    case unknown
    case partialHit
    case fullHit
}
