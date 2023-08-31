//
//  SettingsView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/#converting-components-form
//  https://sarunw.com/posts/swiftui-form-picker-styles/
//  https://www.swiftyplace.com/blog/file-manager-in-swift-reading-writing-and-deleting-files-and-directories

import SwiftUI

struct SettingsView: View {
    // Storing dark mode settings
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // Storing game difficulty settings
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    
    // Deletes all leaderboard data when true
    @State private var isReset = false
    
    // Showing alert
    @State private var showAlert = false
    
    // Disable certain actions if shown during gameplay
    @State var isInGame = false
    
    // Tracking save data deletion
    @Binding var deleteSaveData: Bool
    
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
                        Text("Changes will take effect in the next game")
                    } header: {
                        Text("Difficulty")
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
            
            // Delete all leaderboard data files
            .onChange(of: isReset) { _ in
                if (isReset) {
                    deleteLeaderboardData()
                    saveGameData(for: Game())
                    isReset = false
                    deleteSaveData = true
                }
            }
            
        }
    }
}
