//
//  GameView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showCover = true
    
    var body: some View {
        VStack {
            
        }
        .fullScreenCover(isPresented: $showCover) {
            NavigationStack {
                VStack {
                    
                }
                
                // Different behaviour when using SheetToolbar()
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
