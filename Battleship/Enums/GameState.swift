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

//  GameState: Store the status of the current game
// Identifiable for win/lose sheet in GameView

enum GameState: Identifiable, Codable {
    case setup
    case lose
    case ongoing
    case win
    case exit
    
    var id: UUID { UUID() }
}
