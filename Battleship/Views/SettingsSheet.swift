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

struct SettingsSheet: View {
    // Storing dark mode settings
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // Storing game difficulty settings
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    
    // Deletes all leaderboard data when true
    @State private var isReset = false
    
    // Showing alert
    @State private var showAlert = false
    
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
                        .disabled(isInGame)
                        
                        Text(selectedDifficulty.description)
                        
                        if (isInGame) {
                            Text("Difficulty cannot be changed during gameplay")
                        }
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
                        }
                    }
                }
            }
            .toolbar {
                SheetToolbar()
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
                if isReset {
                    for difficulty in Difficulty.allCases {
                        let fileName = "\(difficulty.rawValue.lowercased()).json"
                        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                            let file = dir.appendingPathComponent(fileName)
                            if FileManager.default.fileExists(atPath: file.path) {
                                do {
                                    try FileManager.default.removeItem(at: file)
                                } catch let error {
                                    print(error)
                                }
                            }
                        }
                        isReset = false
                    }
                }
            }
            
        }
    }
}

struct SettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheet()
    }
}
