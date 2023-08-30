//
//  GameLoseSheet.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 30/08/2023.
//

import SwiftUI

struct GameLoseSheet: View {
    @ObservedObject var game: Game
    @State private var horizontalSpacing: CGFloat = 0
    @State private var verticalSpacing: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                Text("You Lose")
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Spacer()
                    Grid(horizontalSpacing: horizontalSpacing, verticalSpacing: verticalSpacing) {
                        ForEach(0..<game.dimension, id: \.self) { y in
                            GridRow {
                                ForEach(0..<game.dimension, id: \.self) { x in
                                    ZStack {
                                        Button {

                                        } label: {
                                            Text("")
                                                .frame(width: 5, height: 15)
                                        }
                                        .buttonStyle(.borderedProminent)
                                        
                                        if (game.fleet.occupy().contains(Coordinate(x, y))) {
                                            Circle()
                                                .fill(.red)
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
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension)
                verticalSpacing = geo.size.height / 3 / CGFloat(game.dimension)
            }
            .onChange(of: geo.size) { _ in
                horizontalSpacing = geo.size.width / 2 / CGFloat(game.dimension)
                verticalSpacing = geo.size.height / 3 / CGFloat(game.dimension)
            }
        }
    }
}

struct GameLoseSheet_Previews: PreviewProvider {
    static var previews: some View {
        GameLoseSheet(game: Game())
    }
}

