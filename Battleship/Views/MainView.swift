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
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showAlert = false
    @State private var showSheet: showSheets?
    
    enum showSheets: String, Identifiable {
        case leaderboard, settings, howToPlay
        
        var id: String { rawValue }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(isDarkMode ? "rmit-logo-white" : "rmit-logo-black")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text("Battleship")
                    .font(.largeTitle)
                    .bold()
                
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
        .onAppear {
            if isFirstLaunch {
                isDarkMode = colorScheme == .dark ? true : false
                isFirstLaunch = false
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .alert("Information", isPresented: $showAlert) {
            // Default is already "OK" Button
        } message: {
            VStack {
                Text("Name: Tran Thanh Tung\nStudent ID: s3927562\nProgram: BH120 - Bachelor of Engineering (Software Engineering) (Honours)")
            }
        }
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
