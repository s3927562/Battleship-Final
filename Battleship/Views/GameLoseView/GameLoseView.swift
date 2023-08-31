/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 30/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 Grid - Apple Developer Documentation: https://developer.apple.com/documentation/swiftui/grid
 Get width of a view using in SwiftUI: https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui
 */

import SwiftUI

struct GameLoseView: View {
    // Get game data, grid spacing and size from GameView
    @ObservedObject var game: Game
    @Binding var horizontalSpacing: CGFloat
    @Binding var verticalSpacing: CGFloat
    @Binding var scaledSize: CGFloat
    
    var body: some View {
        // Combination of VStack, HStack and Spacers to fix GeometryReader
        GeometryReader { geo in
            if (geo.size.height > geo.size.width) {
                // Verticle view
                VStack {
                    Spacer()
                    Text("Game Over")
                        .font(.largeTitle)
                    Spacer()
                    HStack {
                        Spacer()
                        SolutionGrid(game: game, horizontalSpacing: $horizontalSpacing, verticalSpacing: $verticalSpacing, scaledSize: $scaledSize)
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                // Horizontal view
                HStack {
                    Spacer()
                    Text("Game Over")
                        .font(.largeTitle)
                    Spacer()
                    VStack {
                        Spacer()
                        SolutionGrid(game: game, horizontalSpacing: $horizontalSpacing, verticalSpacing: $verticalSpacing, scaledSize: $scaledSize)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}
