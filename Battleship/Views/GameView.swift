//
//  GameView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//
//  https://developer.apple.com/documentation/swiftui/grid
//  https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui

import SwiftUI

struct GameView: View {
    // For dismissing sheets and go to previous view of a NavigationStack
    @Environment(\.dismiss) private var dismiss
    
    // Read difficulty settings and game data
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    @StateObject var game = Game()
    @ObservedObject var savedGame = Game()
    
    // Show winning or losing sheet
    @State private var showCover: GameState?
    
    // For settings sheet
    @State private var showSheet = false
    
    // Adpating view during rotation
    @State private var horizontalSpacing: CGFloat = 0
    @State private var verticalSpacing: CGFloat = 0
    @State private var scaledSize: CGFloat = 0
    
    // Tracking save data changes
    @Binding var newSaveData: Bool
    
    var body: some View {
        // Combination of VStack, HStack and Spacers to fix GeometryReader
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // A Grid of Button representing Ocean
                    Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
                        ForEach(0..<game.dimension, id: \.self) { y in
                            GridRow {
                                ForEach(0..<game.dimension, id: \.self) { x in
                                    ZStack {
                                        Button {
                                            game.shoot(location: Coordinate(x, y))
                                            
                                            // Save game data
                                            saveGameData(for: game)
                                            newSaveData = true
                                        } label: {
                                            Text("")
                                                .frame(width: scaledSize, height: scaledSize + 10)
                                        }
                                        .buttonStyle(.borderedProminent)
                                        
                                        // Circle to show status of the block
                                        if (!game.oceanStates.isEmpty && game.oceanStates[x][y] != .unknown) {
                                            Circle()
                                                .fill(oceanStateColor(for: game.oceanStates[x][y]))
                                                .frame(width: scaledSize + 5, height: scaledSize + 5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .toolbar {
                // Move counter and limit
                ToolbarItem(placement: .bottomBar) {
                    Text("Moves: \(game.moveCount) / \(game.moveLimit)")
                }
                
                // Settings Icon
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            
            .onAppear {
                if (savedGame.state != .ongoing) {
                    // Setup new game if no save data provided
                    game.dimension = selectedDifficulty.dimension
                    game.moveLimit = selectedDifficulty.moveLimit
                    game.start()
                } else {
                    // Copy from save game data
                    game.dimension = savedGame.dimension
                    game.fleet = savedGame.fleet
                    game.ocean = savedGame.ocean
                    game.moveCount = savedGame.moveCount
                    game.moveLimit = savedGame.moveLimit
                    game.oceanStates = savedGame.oceanStates
                    game.state = savedGame.state
                }
                
                // Setup Grid view
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension + 4)
                verticalSpacing = geo.size.height / 2 / CGFloat(game.dimension + 4)
                let intSize = min(geo.size.width, geo.size.height) / 20
                scaledSize =  intSize / CGFloat(game.dimension)
            }
            
            // Changing Grid spacing on rotation
            .onChange(of: geo.size) { _ in
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension + 4)
                verticalSpacing = geo.size.height / 2 / CGFloat(game.dimension + 4)
                let intSize = min(geo.size.width, geo.size.height) / 20
                scaledSize =  intSize / CGFloat(game.dimension)
                
                // Fix crashing when rotating with fullScreenCover on
                showCover = nil
            }
            
            // Show the correct sheet on winning or losing
            .onChange(of: game.state) { _ in
                if (game.state == .win || game.state == .lose) {
                    showCover = game.state
                }
            }
            .fullScreenCover(item: $showCover) { sheet in
                NavigationStack {
                    VStack {
                        if (sheet == .win) {
                            GameWinView()
                        } else if (sheet == .lose) {
                            GameLoseView(game: game)
                        }
                    }
                    .toolbar {
                        if (sheet == .lose) {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    game.state = .exit
                                    dismiss()
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 17, weight: .semibold))
                                    Text("Main Menu")
                                }
                            }
                        }
                    }
                }
            }
            
            // Fix crashing when rotating with fullScreenCover on
            .onChange(of: showCover) { _ in
                if ((game.state == .win || game.state == .lose) && showCover == nil) {
                    showCover = game.state
                }
            }
            
            // Settings Sheet
            .sheet(isPresented: $showSheet) {
                SettingsView(isInGame: true, deleteSaveData: $newSaveData)
            }
        }
    }
    
    // Coloring circle for oceanState
    func oceanStateColor(for state: OceanState) -> Color {
        if (state == .partialHit) {
            return .yellow
        } else if (state == .fullHit) {
            return .red
        }
        return .white
    }
}
