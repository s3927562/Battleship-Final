/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 31/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 How to create SwiftUI Picker from Enum | Sarunw: https://sarunw.com/posts/swiftui-picker-enum
 */

import Foundation
import SwiftUI

//  CaseIterable: ForEach view

enum Achievement: String, Codable, CaseIterable {
    case goodJob
    case goodLuck
    case perfectGame
    
    var title: String {
        switch self {
        case .goodJob: return String(localized: "Good Job")
        case .goodLuck: return String(localized: "Better Luck Next Time")
        case .perfectGame: return String(localized: "Perfect Game")
        }
    }
    
    var description: String {
        switch self {
        case .goodJob: return String(localized: "Win a game")
        case .goodLuck: return String(localized: "Lose a game")
        case .perfectGame: return String(localized: "Win a game without any miss")
        }
    }
    
    var imageName: String {
        switch self {
        case .goodJob: return "checkmark.circle.fill"
        case .goodLuck: return "exclamationmark.triangle.fill"
        case .perfectGame: return "checkmark.seal.fill"
        }
    }
    
    var image: Image {
        return Image(systemName: self.imageName)
    }
}
