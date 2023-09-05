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

struct AppearanceSection: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        // Dark Mode Settings
        Section {
            Toggle("Dark Mode", isOn: $isDarkMode)
        } header: {
            Text("Appearance")
        }
    }
}
