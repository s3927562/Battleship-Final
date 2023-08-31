//
//  ContentView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://www.avanderlee.com/swiftui/presenting-sheets/
//  https://stackoverflow.com/questions/57517803/how-to-remove-the-default-navigation-bar-space-in-swiftui-navigationview
//  https://developer.apple.com/forums/thread/719989

import SwiftUI

struct MainView: View {
    // Get system color scheme
    @Environment(\.colorScheme) private var colorScheme
    
    // Check for first launch to set dark mode settings
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    // Storing dark mode settings
    @AppStorage("isDarkMode") private var isDarkMode = false
    
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
                        Text("Leaderboards & Statistics")
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
            if (game.state == .ongoing) {
                disableContinue = false
            } else {
                disableContinue = true
            }
        }
        
        // Detect change in save data
        .onChange(of: newSaveData) { _ in
            if (newSaveData) {
                game = readGameData() ?? Game()
                newSaveData = false
            }
            
            if (game.state == .ongoing) {
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
