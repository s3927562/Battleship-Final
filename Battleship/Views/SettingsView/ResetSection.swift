/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 05/09/2023
 Last modified: 05/09/2023
 Acknowledgement: RMIT University, COSC2659 Course, Week 1 - 5 Lecture Slides & Videos
 */

import SwiftUI

struct ResetSection: View {
    // Showing alert
    @State private var showAlert = false
    
    @Binding var isReset: Bool
    var isInGame = false
    
    var body: some View {
        // Button for deleting leaderboard data files
        Section {
            Button("Reset All Data", role: .destructive) {
                showAlert = true
            }
            .disabled(isInGame)
            
            if (isInGame) {
                Text("Data cannot be reset during gameplay")
                    .foregroundColor(.gray)
            }
        }
        
        // Alert for deleting leaderboard data files
        .alert("Reset All Data", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                isReset = true
            }
        } message: {
            Text("This action cannot be undone")
        }
    }
}
