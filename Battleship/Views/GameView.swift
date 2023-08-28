//
//  GameView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 28/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var game = Game()
    @State private var showCover = false
    @State private var range = 0..<0
    @State private var columns: [GridItem] = []
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: CGFloat(8 * (9 - game.columns))) {
                ForEach(range, id: \.self) {index in
                    let y = index / game.rows
                    let x = index - (y * game.columns)
                    let location = Coordinate(x: x, y: y)
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
                game.rows = 8
                game.columns = 8
                range = 0..<(game.columns * game.rows)
                columns = [GridItem](repeating: GridItem(.flexible(), spacing: 0), count: game.columns)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("Moves: \(game.moves)")
                }
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

