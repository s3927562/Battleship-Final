//
//  ContentView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://www.avanderlee.com/swiftui/presenting-sheets/

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
                
                Button {
                    
                } label: {
                    Text("New Game")
                        .frame(maxWidth: .infinity, maxHeight: 32)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    
                } label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity, maxHeight: 32)
                }
                .buttonStyle(.bordered)
                .disabled(true)
                
                Button {
                    showSheet = .leaderboard
                } label: {
                    Text("Leaderboards & Statistics")
                        .frame(height: 32)
                }
                
                Button {
                    showSheet = .settings
                } label: {
                    Text("Settings")
                        .frame(height: 32)
                }
                
                Button {
                    showSheet = .howToPlay
                } label: {
                    Text("How to Play")
                        .frame(height: 32)
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
        .sheet(item: $showSheet, content: { sheet in
            switch sheet {
            case .leaderboard: LeaderboardView()
            case .settings: SettingsView()
            case .howToPlay: MainView()
            }
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
