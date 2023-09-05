/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 05/09/2023
 Last modified: 05/09/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 5 Lecture Slides & Videos
 */

import SwiftUI

struct DifficultySection: View {
    @Binding var difficulty: Difficulty
    
    var body: some View {
        // Game Difficulty Settings & Description
        Section {
            Picker("", selection: $difficulty) {
                ForEach(Difficulty.allCases.sorted { $0.dimension < $1.dimension }, id: \.self) {
                    Text($0.textValue)
                }
            }
            .pickerStyle(.segmented)
            
            Text(difficulty.description)
            Text("Changes will take effect from the next new game")
        } header: {
            Text("Difficulty")
        }
    }
}

struct DifficultySection_Previews: PreviewProvider {
    @AppStorage("selectedDifficulty") private static var selectedDifficulty: Difficulty = .Easy
    static var previews: some View {
        Form {
            DifficultySection(difficulty: $selectedDifficulty)
        }
    }
}
