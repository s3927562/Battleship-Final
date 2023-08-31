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
 Building forms with SwiftUI: A comprehensive guide - LogRocket Blog: https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide
 4 Picker styles in SwiftUI Form | Sarunw: https://sarunw.com/posts/swiftui-form-picker-styles
 */

import SwiftUI

struct SettingsView: View {
    // Storing dark mode settings
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // Storing game difficulty settings
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    
    // Storing volume settings
    @AppStorage("volume") private var volume = 100.0
    
    // Showing alert
    @State private var showAlert = false
    
    // Deletes all leaderboard data when true
    @State var isReset = false
    @Binding var deleteSaveData: Bool
    
    // Disable certain actions if shown during gameplay
    var isInGame = false
    
    var body: some View {
        // NavigationStack for back button
        NavigationStack {
            VStack {
                Form {
                    // Dark Mode Settings
                    Section {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    } header: {
                        Text("Appearance")
                    }
                    
                    // Game Difficulty Settings & Description
                    Section {
                        Picker("", selection: $selectedDifficulty) {
                            ForEach(Difficulty.allCases.sorted { $0.dimension < $1.dimension }, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Text(selectedDifficulty.description)
                        Text("Changes will take effect in the next new game")
                    } header: {
                        Text("Difficulty")
                    }
                    
                    // Volume
                    Section {
                        Slider(value: $volume, in: 0...100, step: 1)
                    } header: {
                        Text("Volume")
                    }
                    
                    // Button for deleting leaderboard data files
                    Section {
                        Button("Reset All Data", role: .destructive) {
                            showAlert = true
                        }
                        .disabled(isInGame)
                        
                        if (isInGame) {
                            Text("Data cannot be reset during gameplay")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                SheetToolbar(isInGame: isInGame)
            }
            
            // Needs to be set again when changing the dark mode setting on a sheet
            .preferredColorScheme(isDarkMode ? .dark : .light)
            
            // Alert for deleting leaderboard data files
            .alert("Reset All Data", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    isReset = true
                }
            } message: {
                Text("This action cannot be undone")
            }
            
            // Delete all leaderboard and game data files
            .onChange(of: isReset) { _ in
                if (isReset) {
                    deleteLeaderboardData()
                    saveGameData(for: Game())
                    deleteSaveData = true
                    isReset = false
                }
            }
        }
    }
}
