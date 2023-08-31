//
//  GameLoseSheet.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 30/08/2023.
//
//  https://developer.apple.com/documentation/swiftui/grid
//  https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui

import SwiftUI

struct GameLoseView: View {
    @ObservedObject var game: Game
    @State private var horizontalSpacing: CGFloat = 0
    @State private var verticalSpacing: CGFloat = 0
    @State private var scaledSize: CGFloat = 0
    
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
                        gridView(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing)
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
                        gridView(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing)
                        Spacer()
                    }
                    Spacer()
                }
            }
            
            // Need a View to use .onAppear
            VStack {}
            .onAppear {
                // Setup Grid spacing
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension + 4)
                verticalSpacing = geo.size.height / 2 / CGFloat(game.dimension + 4)
                let intSize = min(geo.size.width, geo.size.height) / 20
                scaledSize =  intSize / CGFloat(game.dimension)
            }
        }
    }
    
    // Show the Grid with only the ones with a Ship marked
    func gridView(horizontalSpacing: CGFloat, verticalSpacing: CGFloat) -> some View {
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

struct GameLoseSheet_Previews: PreviewProvider {
    static var previews: some View {
        GameLoseView(game: Game())
    }
}

