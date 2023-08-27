//
//  SheetToolbar.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//
//  https://stackoverflow.com/questions/57342170/how-do-i-set-the-size-of-a-sf-symbol-in-swiftui
//  https://stackoverflow.com/questions/66134755/swiftui-extract-toolbarcontent-to-its-own-var
//  https://stackoverflow.com/questions/57233276/dismiss-sheet-swiftui

import SwiftUI

struct SheetToolbar: ToolbarContent {
    @Environment(\.dismiss) private var dismiss
    
    var body: some ToolbarContent {
        // Mimicking back button on views
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
