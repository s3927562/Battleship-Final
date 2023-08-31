/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 31/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import SwiftUI

struct DifficultyPicker: View {
    @Binding var difficulty: Difficulty
    
    var body: some View {
        Section {
            // Picker for choosing which difficulty to display leaderboard and statistics for
            Picker("", selection: $difficulty) {
                ForEach(Difficulty.allCases.sorted { $0.dimension < $1.dimension }, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        } header: {
            Text("Difficulty")
        }
    }
}
