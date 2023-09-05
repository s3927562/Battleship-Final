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
 Sheets in SwiftUI explained with code examples - SwiftLee: https://www.avanderlee.com/swiftui/presenting-sheets
 */

import SwiftUI

struct MainView: View {
    // Get system color scheme
    @Environment(\.colorScheme) private var colorScheme
    
    // Check for first launch to set dark mode settings
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    // Storing dark mode settings
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // Setup volume settings for first launch
    @AppStorage("volumeBGM") private var volumeBGM = 25.0
    @AppStorage("volumeSFX") private var volumeSFX = 37.5
    
    // Read saved game data if any
    @State private var game: Game = readGameData() ?? Game()
    
    // Showing alert
    @State private var showAlert = false
    
    // Choosing which view to show on sheet
    @State private var showSheet: showSheets?
    enum showSheets: String, Identifiable {
        case leaderboard, settings, howToPlay
        
        var id: String { rawValue }
    }
    
    // Tracking save data changes
    @State private var newSaveData = false
    
    // Disable continue button if no save data
    @State private var disableContinue = true
    
    var body: some View {
        NavigationStack {
            VStack {
                // RMIT logo and game title
                Group {
                    Image(isDarkMode ? "rmit-logo-white" : "rmit-logo-black")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                    
                    Text("Battleship")
                        .font(.largeTitle)
                        .bold()
                }
                
                // Buttons
                Group {
                    Spacer()
                    
                    NavigationLink {
                        GameView(newSaveData: $newSaveData)
                    } label: {
                        Text("New Game")
                            .frame(maxWidth: .infinity, maxHeight: 34)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    NavigationLink {
                        GameView(savedGame: game, newSaveData: $newSaveData)
                    } label: {
                        Text("Continue")
                            .frame(maxWidth: .infinity, maxHeight: 34)
                    }
                    .buttonStyle(.bordered)
                    .disabled(disableContinue)
                    
                    Button {
                        showSheet = .leaderboard
                    } label: {
                        Text("Leaderboards, Statistics & Achievements")
                            .frame(height: 34)
                    }
                    
                    Button {
                        showSheet = .settings
                    } label: {
                        Text("Settings")
                            .frame(height: 34)
                    }
                    
                    Button {
                        showSheet = .howToPlay
                    } label: {
                        Text("How to Play")
                            .frame(height: 34)
                    }
                    
                    Spacer()
                }
                
                // Info button
                HStack {
                    Spacer()
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.white, Color.accentColor)
                    }
                }
            }
            .padding()
            .navigationTitle("Main Menu")
            .navigationBarHidden(true)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
        .onAppear {
            // Settings dark mode on first launch
            if (isFirstLaunch) {
                isDarkMode = colorScheme == .dark ? true : false
                isFirstLaunch = false
            }
            
            // Enable 'Continue' button if there is save data
            if (game.state != .setup && game.state != .exit) {
                disableContinue = false
            } else {
                disableContinue = true
            }
            
            // Play BGM
            UserDefaults.standard.set(volumeBGM, forKey: "volumeBGM")
            UserDefaults.standard.set(volumeSFX, forKey: "volumeSFX")
            playBGM()
        }
        
        // Detect change in save data
        .onChange(of: newSaveData) { _ in
            if (newSaveData) {
                game = readGameData() ?? Game()
                newSaveData = false
            }
            
            if (game.state != .setup && game.state != .exit) {
                disableContinue = false
            } else {
                disableContinue = true
            }
        }
        
        // Info alert
        .alert("Information", isPresented: $showAlert) {
            // Default is already "OK" Button
        } message: {
            VStack {
                Text("Name: Tran Thanh Tung\nStudent ID: s3927562\nProgram: BH120 - Bachelor of Engineering (Software Engineering) (Honours)")
            }
        }
        
        // Sheet views
        .sheet(item: $showSheet) { sheet in
            switch sheet {
            case .leaderboard: LeaderboardView()
            case .settings: SettingsView(deleteSaveData: $newSaveData)
            case .howToPlay: HowToPlayView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
