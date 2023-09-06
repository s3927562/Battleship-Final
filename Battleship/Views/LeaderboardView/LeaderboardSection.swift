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

struct LeaderboardSection: View {
    @Binding var leaderboard: Leaderboard
    
    var body: some View {
        Section {
            // Show top 10 scores
            ForEach(leaderboard.scores) {
                if ($0.username == "" && $0.score <= 0) {
                    // Display "None" for both entries if no username and score
                    LabeledContent("None", value: String(localized: "None"))
                } else {
                    LabeledContent($0.username, value: String($0.score))
                }
            }
        } header: {
            Text("Leaderboard")
        }
    }
}

struct LeaderboardSection_Previews: PreviewProvider {
    @State private static var selectedLeaderboard = leaderboardDict["Easy"]!
    static var previews: some View {
        Form {
            LeaderboardSection(leaderboard: $selectedLeaderboard)
        }
    }
}
