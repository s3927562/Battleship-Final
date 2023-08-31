
//  https://stackoverflow.com/questions/66134755/swiftui-extract-toolbarcontent-to-its-own-var
//  https://stackoverflow.com/questions/57233276/dismiss-sheet-swiftui
/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 27/08/2023
 Last modified: 31/08/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 9 Lecture Slides & Videos
 ios - SwiftUI Extract @ToolbarContent to its own var - Stack Overflow: https://stackoverflow.com/questions/66134755/swiftui-extract-toolbarcontent-to-its-own-var
 Dismiss sheet SwiftUI - Stack Overflow: https://stackoverflow.com/questions/57233276/dismiss-sheet-swiftui
 */

import SwiftUI

struct SheetToolbar: ToolbarContent {
    // For dismissing sheet
    @Environment(\.dismiss) private var dismiss
    
    // Change back button during gameplay
    var isInGame = false
    
    var body: some ToolbarContent {
        // Mimicking back button on views
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
                if (isInGame) {
                    Text("Back to Game")
                } else {
                    Text("Main Menu")
                }
            }
        }
    }
}
