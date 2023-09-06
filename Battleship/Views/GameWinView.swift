/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 30/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import SwiftUI

struct GameWinView: View {
    // Get game data and return back player name
    @ObservedObject var game: Game
    @Binding var name: String
    
    var body: some View {
        Text ("You Won!")
            .font(.largeTitle)
        
        // Form for inputting name
        Form {
            LabeledContent {
                TextField("Name", text: $name)
                    .multilineTextAlignment(.trailing)
            } label: {
                Text("Name")
            }
            
            LabeledContent("Score", value: String(game.moveLimit - game.moveCount + 1))
        }
    }
}
