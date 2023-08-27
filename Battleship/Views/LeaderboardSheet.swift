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
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDifficulty = "Easy"
    @State private var selectedLeaderboard = Leaderboard()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Picker("", selection: $selectedDifficulty) {
                            ForEach(Array(difficultyDict).sorted { $0.value.id < $1.value.id }, id: \.self.key) {
                                Text($0.key)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Difficulty")
                    }
                    
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
                    
                    Section {
                        LabeledContent("Games Total", value: String(selectedLeaderboard.total))
                        LabeledContent("Games Won", value: "\(selectedLeaderboard.win) (\(selectedLeaderboard.winPercentage)%)")
                    } header: {
                        Text("Statistics")
                    }
                }
            }
            .onAppear {
                selectedLeaderboard = leaderboardDict[selectedDifficulty]!
            }
            .onChange(of: selectedDifficulty) { _ in
                selectedLeaderboard = leaderboardDict[selectedDifficulty]!
            }
            .toolbar {
                SheetToolbar()
            }
        }
    }
}

struct LeaderboardSheet_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardSheet()
    }
}
