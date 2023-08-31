/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 27/08/2023
 Last modified: 31/08/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 5 Lecture Slides & Videos
 */

import SwiftUI

struct HowToPlayView: View {
    // Change back button
    var isInGame = false
    
    var body: some View {
        // NavigationStack for back button
        NavigationStack {
            VStack {
                HStack {
                    Text("In each game, a fleet will be deployed with 5 ships of the following size: 2, 3, 3, 4, 5.\r\n")
                    Spacer()
                    
                }
                
                HStack {
                    Text("You must sink all ships before you run out of move. The move counter and limit is displayed at the bottom of the scren.\r\n")
                    Spacer()
                }
                
                HStack {
                    Text("The field is a square grid with the dimension based on the difficulty. Each location is represented with a blank button.")
                    Spacer()
                }
                
                Button {
                    
                } label: {
                    Text("")
                        .frame(width: 5, height: 15)
                }
                .buttonStyle(.borderedProminent)
                
                HStack {
                    Text("Tapping on the button will shoot at the location and provide a hint to whether the shot hit a ship or not:")
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        Button {
                            
                        } label: {
                            Text("")
                                .frame(width: 5, height: 15)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 10, height: 10)
                    }
                    Text("The shot did not hit anything.")
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        Button {
                            
                        } label: {
                            Text("")
                                .frame(width: 5, height: 15)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Circle()
                            .fill(Color(red: 0.99, green: 0.60, blue: 0.00))
                            .frame(width: 10, height: 10)
                    }
                    Text("The shot hit a ship, but the ship has not sunk.")
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        Button {
                            
                        } label: {
                            Text("")
                                .frame(width: 5, height: 15)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Circle()
                            .fill(.red)
                            .frame(width: 10, height: 10)
                    }
                    Text("The shot hit a ship and the ship has sunk.")
                    Spacer()
                }
                
                HStack {
                    Text("The score is calculated by subtracting the move count from move limit then adding 1.")
                    Spacer()
                }
                
                Spacer()
            }
            .navigationTitle("How to Play")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                SheetToolbar(isInGame: isInGame)
            }
            .padding()
        }
    }
}

struct HowToPlaySheet_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
