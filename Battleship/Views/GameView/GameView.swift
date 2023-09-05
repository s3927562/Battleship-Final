/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 28/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 Grid - Apple Developer Documentation: https://developer.apple.com/documentation/swiftui/grid
 Get width of a view using in SwiftUI: https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui
 */

import SwiftUI

struct GameView: View {
    // For dismissing sheets and go to previous view of a NavigationStack
    @Environment(\.dismiss) private var dismiss
    
    // Read difficulty settings and game data
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    @StateObject var game = Game()
    @ObservedObject var savedGame = Game()
    
    // Show winning or losing sheet
    @State private var winCover = false
    @State private var loseCover = false
    
    // For settings and help sheet
    @State private var showSheet: showSheets?
    enum showSheets: String, Identifiable {
        case settings, howToPlay
        
        var id: String { rawValue }
    }
    
    // Adpating view during rotation
    @State private var horizontalSpacing: CGFloat = 0
    @State private var verticalSpacing: CGFloat = 0
    @State private var scaledSize: CGFloat = 0
    
    // Name when game win
    @State private var name = ""
    
    // Tracking save data changes
    @Binding var newSaveData: Bool
    
    var body: some View {
        // Combination of VStack, HStack and Spacers to fix GeometryReader
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    PlayGrid(game: game, horizontalSpacing: $horizontalSpacing, verticalSpacing: $verticalSpacing, scaledSize: $scaledSize, newSaveData: $newSaveData)
                    Spacer()
                }
                Spacer()
            }
            .toolbar {
                // Move counter and limit at the bottom
                ToolbarItem(placement: .bottomBar) {
                    Text("Moves: \(game.moveCount) / \(game.moveLimit)")
                }
                
                // Settings and Help icon on top right
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = .settings
                    } label: {
                        Image(systemName: "gear")
                    }
                    
                    Button {
                        showSheet = .howToPlay
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                }
            }
            
            .onAppear {
                if (savedGame.state == .setup) {
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
                scaledSize =  intSize / CGFloat(game.dimension) + 5
            }
            
            // Changing Grid spacing on rotation
            .onChange(of: geo.size) { _ in
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension + 4)
                verticalSpacing = geo.size.height / 2 / CGFloat(game.dimension + 4)
                let intSize = min(geo.size.width, geo.size.height) / 20
                scaledSize =  intSize / CGFloat(game.dimension) + 5
            }
            
            // Show the correct sheet on winning or losing
            .onChange(of: game.state) { _ in
                if (game.state == .win) {
                    winCover = true
                } else if (game.state == .lose) {
                    loseCover = true
                }
            }
            
            // Win sheet
            .fullScreenCover(isPresented: $winCover) {
                VStack {
                    GameWinView(game: game, name: $name)
                    
                    Section {
                        Button {
                            saveLeaderboardData(username: name, game: game, difficulty: selectedDifficulty)
                            game.state = .exit
                            newSaveData = true
                            saveGameData(for: game)
                            dismiss()
                        } label: {
                            Text("Save")
                                .frame(maxWidth: .infinity, maxHeight: 34)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            game.state = .exit
                            saveGameData(for: game)
                            newSaveData = true
                            saveLeaderboardData(username: name, game: game, difficulty: selectedDifficulty)
                            dismiss()
                        } label: {
                            Text("Don't Save")
                                .frame(maxWidth: .infinity, maxHeight: 34)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding([.leading, .trailing])
                }
                .padding([.top, .bottom])
            }
            
            // Lose sheet
            .fullScreenCover(isPresented: $loseCover) {
                NavigationStack {
                    VStack {
                        GameLoseView(game: game, horizontalSpacing: $horizontalSpacing, verticalSpacing: $verticalSpacing, scaledSize: $scaledSize)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                saveLeaderboardData(username: name, game: game, difficulty: selectedDifficulty)
                                game.state = .exit
                                saveGameData(for: game)
                                newSaveData = true
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Main Menu")
                            }
                        }
                    }
                    .padding([.top, .bottom])
                }
            }
            
            // Settings and Help Sheet
            .sheet(item: $showSheet) { sheet in
                switch sheet {
                case .settings: SettingsView(deleteSaveData: $newSaveData, isInGame: true)
                case .howToPlay: HowToPlayView(isInGame: true)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    @State private static var newSaveData = false
    static var previews: some View {
        GameView(newSaveData: $newSaveData)
    }
}
