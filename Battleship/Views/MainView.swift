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
    
    // Showing alert
    @State private var showAlert = false
    
    // Choosing which view to show on sheet
    @State private var showSheet: showSheets?
    enum showSheets: String, Identifiable {
        case leaderboard, settings, howToPlay
        
        var id: String { rawValue }
    }
    
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
                        GameView()
                    } label: {
                        Text("New Game")
                            .frame(maxWidth: .infinity, maxHeight: 34)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        
                    } label: {
                        Text("Continue")
                            .frame(maxWidth: .infinity, maxHeight: 34)
                    }
                    .buttonStyle(.bordered)
                    .disabled(true)
                    
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
            if isFirstLaunch {
                isDarkMode = colorScheme == .dark ? true : false
                isFirstLaunch = false
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
            case .leaderboard: LeaderboardSheet()
            case .settings: SettingsSheet()
            case .howToPlay: HowToPlaySheet()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
