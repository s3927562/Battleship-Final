/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 31/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 */

import SwiftUI

struct PlayGrid: View {
    @ObservedObject var game: Game
    @Binding var horizontalSpacing: CGFloat
    @Binding var verticalSpacing: CGFloat
    @Binding var scaledSize: CGFloat
    @Binding var newSaveData: Bool
    
    var body: some View {
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
    }
    
    // Coloring circle for oceanState
    func oceanStateColor(for state: OceanState) -> Color {
        if (state == .partialHit) {
            return Color(red: 0.99, green: 0.60, blue: 0.00)
        } else if (state == .fullHit) {
            return .red
        }
        return .white
    }
}
