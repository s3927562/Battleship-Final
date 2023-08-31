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

struct StatisticSection: View {
    @Binding var leaderboard: Leaderboard
    
    var body: some View {
        Section {
            // Total games and games won
            LabeledContent("Games Total", value: String(leaderboard.total))
            LabeledContent("Games Won", value: "\(leaderboard.win) (\(leaderboard.winPercentage)%)")
        } header: {
            Text("Statistics")
        }
    }
}
