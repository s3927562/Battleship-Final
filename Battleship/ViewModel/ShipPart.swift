/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 28/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import Foundation

//  ShipPart: A part of a Ship with Coordinate and hit status
//  'class' to mutate isHit

class ShipPart: Codable {
    let location: Coordinate
    var isHit = false
    
    init(location: Coordinate) {
        self.location = location
    }
}
