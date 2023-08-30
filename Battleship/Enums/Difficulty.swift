//
//  Difficulty.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//
//  https://sarunw.com/posts/swiftui-picker-enum/

import Foundation

enum Difficulty: String, CaseIterable {
    case Easy
    case Medium
    case Hard
    
    var dimension: Int {
        switch self {
        case .Easy: return 6
        case .Medium: return 7
        case .Hard: return 8
        }
    }
    
    var moveLimit: Int {
        return self.dimension * self.dimension * 75 / 100
    }
    
    var description: String {
        "\(self.dimension) x \(self.dimension) Grid, Maximum \(moveLimit) moves"
    }
}
