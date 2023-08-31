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

struct AchievementSection: View {
    @Binding var leaderboard: Leaderboard
    
    var body: some View {
        Section {
            List {
                // For each achievement is enum
                ForEach(Achievement.allCases, id:\.self) { achievement in
                    HStack {
                        if (leaderboard.achievements.contains(achievement)) {
                            // Display achievement name, description, and icon if achievement
                            VStack {
                                HStack {
                                    Text(achievement.title)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(achievement.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }
                            Spacer()
                            achievement.image
                                .font(.title)
                                .foregroundColor(.accentColor)
                        } else {
                            // Display question marks if not achieved
                            VStack {
                                HStack {
                                    Text("???")
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("???")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                            }
                            Spacer()
                            Image(systemName: "questionmark.square.dashed")
                                .font(.title)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
        } header: {
            Text("Achievements")
        }
    }
}
