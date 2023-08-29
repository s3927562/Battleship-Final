//
//  LeaderboardView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/#converting-components-form
//  https://sarunw.com/posts/swiftui-form-picker-styles/

import SwiftUI

struct LeaderboardSheet: View {
    @State private var selectedDifficulty: Difficulty = .Easy
    @State private var selectedLeaderboard = Leaderboard()
    
    var body: some View {
        // NavigationStack for back button
        NavigationStack {
            VStack {
                Form {
                    // Picker for choosing which difficulty to display leaderboard and statistics for
                    Section {
                        Picker("", selection: $selectedDifficulty) {
                            ForEach(Difficulty.allCases.sorted { $0.dimension < $1.dimension }, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Difficulty")
                    }
                    
                    // Leaderboard
                    Section {
                        ForEach(selectedLeaderboard.scores) {
                            if ($0.username == "" && $0.score == 0) {
                                LabeledContent("None", value: "None")
                            } else {
                                LabeledContent($0.username, value: String($0.score))
                            }
                        }
                    } header: {
                        Text("Leaderboard")
                    }
                    
                    // Statistics
                    Section {
                        LabeledContent("Games Total", value: String(selectedLeaderboard.total))
                        LabeledContent("Games Won", value: "\(selectedLeaderboard.win) (\(selectedLeaderboard.winPercentage)%)")
                    } header: {
                        Text("Statistics")
                    }
                }
            }
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

struct LeaderboardSheet_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardSheet()
    }
}
