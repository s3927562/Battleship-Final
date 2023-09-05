/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 26/08/2023
 Last modified: 05/09/2023
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
    @AppStorage("volumeBGM") private var volumeBGM = 25.0
    @AppStorage("volumeSFX") private var volumeSFX = 37.5
    
    // Storing display language
    @AppStorage("appLang") private var appLang: Language = .en
    
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
                    AppearanceSection(isDarkMode: $isDarkMode)
                    DifficultySection(difficulty: $selectedDifficulty)
                    LanguageSection(language: $appLang)
                    VolumeSection(volumeBGM: $volumeBGM, volumeSFX: $volumeSFX)
                    ResetSection(isReset: $isReset, isInGame: isInGame)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                SheetToolbar(isInGame: isInGame)
            }
            
            // Needs to be set again when changing the dark mode setting on a sheet
            .preferredColorScheme(isDarkMode ? .dark : .light)
            
            // Delete all leaderboard and game data files
            .onChange(of: isReset) { _ in
                if (isReset) {
                    deleteLeaderboardData()
                    saveGameData(for: Game())
                    deleteSaveData = true
                    isReset = false
                }
            }
            
            // Changing volume
            .onChange(of: volumeBGM) { _ in
                changeVolume(to: Float(volumeBGM), type: .BGM)
            }
            .onChange(of: volumeSFX) { _ in
                changeVolume(to: Float(volumeSFX), type: .SFX)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State private static var deleteSaveData = false
    static var previews: some View {
        SettingsView(deleteSaveData: $deleteSaveData)
    }
}
