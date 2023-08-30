//
//  GameView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//
//  https://developer.apple.com/documentation/swiftui/grid
//  https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui
//

import SwiftUI

struct GameView: View {
    // For dismissing sheets and go to previous view of a NavigationStack
    @Environment(\.dismiss) private var dismiss
    
    // Read difficulty settings
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    @StateObject private var game = Game()
    
    // Show after winning or losing
    @State private var showCover: GameState?
    
    // For settings sheet
    @State private var showSheet = false
    
    // Adpating view during rotation
    @State private var viewSize: CGSize = .zero
    @State private var horizontalSpacing: CGFloat = 0
    @State private var verticalSpacing: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
                        ForEach(0..<game.dimension, id: \.self) { y in
                            GridRow {
                                ForEach(0..<game.dimension, id: \.self) { x in
                                    ZStack {
                                        Button {
                                            game.shoot(location: Coordinate(x, y))
                                        } label: {
                                            Text("")
                                                .frame(width: 5, height: 15)
                                        }
                                        .buttonStyle(.borderedProminent)
                                        
                                        if (!game.oceanStates.isEmpty && game.oceanStates[x][y] != .unknown) {
                                            Circle()
                                                .fill(circleColor(state: game.oceanStates[x][y]))
                                                .frame(width: 10, height: 10)
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
            .onAppear {
                game.dimension = selectedDifficulty.dimension
                game.moveLimit = selectedDifficulty.moveLimit
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension)
                verticalSpacing = geo.size.height / 2 / CGFloat(game.dimension)
                game.start()
            }
            .onChange(of: geo.size) { _ in
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension)
                verticalSpacing = geo.size.height / 2 / CGFloat(game.dimension)
            }
            .onChange(of: game.state) { _ in
                if (game.state != .ongoing) {
                    showCover = game.state
                }
            }
            .fullScreenCover(item: $showCover) { sheet in
                NavigationStack {
                    VStack {
                        if (sheet == .win) {
                            GameWinSheet()
                        } else if (sheet == .lose) {
                            GameLoseSheet(game: game)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
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
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Text("Moves: \(game.moveCount) / \(game.moveLimit)")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                SettingsSheet(isInGame: true)
            }
        }
    }
    
    func circleColor(state: OceanState) -> Color {
        if (state == .partialHit) {
            return .yellow
        } else if (state == .fullHit) {
            return .red
        }
        return .white
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

