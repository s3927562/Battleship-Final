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

struct SolutionGrid: View {
    @ObservedObject var game: Game
    @Binding var horizontalSpacing: CGFloat
    @Binding var verticalSpacing: CGFloat
    @Binding var scaledSize: CGFloat
    
    var body: some View {
        Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
            ForEach(0..<game.dimension, id: \.self) { y in
                GridRow {
                    ForEach(0..<game.dimension, id: \.self) { x in
                        ZStack {
                            Button {
                                
                            } label: {
                                Text("")
                                    .frame(width: scaledSize, height: scaledSize + 10)
                            }
                            .buttonStyle(.borderedProminent)
                            
                            if (game.fleet.occupy().contains(Coordinate(x, y))) {
                                Circle()
                                    .fill(.red)
                                    .frame(width: scaledSize + 5, height: scaledSize + 5)
                            }
                        }
                    }
                }
            }
        }
    }
}
