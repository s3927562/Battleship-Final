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
 swift-evolution/proposals/0185-synthesize-equatable-hashable.md at main · apple/swift-evolution · GitHub: https://github.com/apple/swift-evolution/blob/main/proposals/0185-synthesize-equatable-hashable.md
 */

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
