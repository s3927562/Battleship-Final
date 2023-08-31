/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 26/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 Grid - Apple Developer Documentation: https://developer.apple.com/documentation/swiftui/grid
 Get width of a view using in SwiftUI: https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui
 Building forms with SwiftUI: A comprehensive guide - LogRocket Blog: https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide
 4 Picker styles in SwiftUI Form | Sarunw: https://sarunw.com/posts/swiftui-form-picker-styles
 */

import SwiftUI

struct LeaderboardView: View {
    @State private var selectedDifficulty: Difficulty = .Easy
    @State private var selectedLeaderboard = Leaderboard()
    
    var body: some View {
        // NavigationStack for back button
        NavigationStack {
            VStack {
                Form {
                    DifficultyPicker(difficulty: $selectedDifficulty)
                    LeaderboardSection(leaderboard: $selectedLeaderboard)
                    StatisticSection(leaderboard: $selectedLeaderboard)
                    AchievementSection(leaderboard: $selectedLeaderboard)
                }
            }
            .navigationTitle("Leaderboard and Statistics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                SheetToolbar()
            }
            
            // Set leaderboard to display on view appearing and changing difficulty
            .onAppear {
                selectedLeaderboard = leaderboardDict[selectedDifficulty.rawValue]!
            }
            .onChange(of: selectedDifficulty) { _ in
                selectedLeaderboard = leaderboardDict[selectedDifficulty.rawValue]!
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
