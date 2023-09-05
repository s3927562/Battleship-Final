/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 27/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 How to create SwiftUI Picker from Enum | Sarunw: https://sarunw.com/posts/swiftui-picker-enum
 */

import Foundation

//  Difficulty: Store game settings related to difficulty
//  CaseIterable: ForEach view

enum Difficulty: String, CaseIterable {
    case Easy
    case Medium
    case Hard
    
    var textValue: String {
        switch self {
        case .Easy: return String(localized: "Easy")
        case .Medium: return String(localized: "Medium")
        case .Hard: return String(localized: "Hard")
        }
    }
    
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
        String(localized: "\(self.dimension) x \(self.dimension) Grid, Maximum \(moveLimit) Moves")
    }
}
