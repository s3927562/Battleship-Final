//
//  GameView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import SwiftUI

struct GameView: View {
    // For dismissing sheets and go to previous view of a NavigationStack
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("selectedDifficulty") private var selectedDifficulty: Difficulty = .Easy
    @StateObject private var game = Game()
    @State private var showCover = false
    @State private var range = 0..<0
    @State private var columns: [GridItem] = []
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: UIScreen.main.bounds.size.height / CGFloat(game.dimension + 1)) {
                ForEach(range, id: \.self) {index in
                    let y = index / game.dimension
                    let x = index - (y * game.dimension)
                    let location = Coordinate(x, y)
                    ZStack {
                        Button {
                            game.shoot(location: location)
                        } label: {
                            Text("")
                                .frame(width: 16, height: 26)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        if (game.oceanStates[x][y] != .unknown) {
                            Circle()
                                .fill(circleColor(state: game.oceanStates[x][y]))
                                .frame(width: 10, height: 10)
                        }
                    }
                }
            }
            .onAppear {
                game.dimension = selectedDifficulty.dimension
                range = 0..<(game.dimension * game.dimension)
                columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: game.dimension)
                game.start()
            }
            .onChange(of: game.state) { _ in
                if (game.state == .win) {
                    showCover = true
                    print("win")
                }
            }
            .fullScreenCover(isPresented: $showCover) {
                NavigationStack {
                    VStack {
                        
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
                    Text("Moves: \(game.moveCount)")
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

