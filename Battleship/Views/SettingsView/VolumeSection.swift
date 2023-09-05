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

struct VolumeSection: View {
    @Binding var volumeBGM: Double
    @Binding var volumeSFX: Double
    
    var body: some View {
        // Volume
        Section {
            Grid {
                GridRow {
                    Text("BGM")
                    Slider(value: $volumeBGM, in: 0...50, step: 0.5)
                }
                GridRow {
                    Text("SFX")
                    Slider(value: $volumeSFX, in: 0...75, step: 0.75)
                }
            }
        } header: {
            Text("Volume")
        }
    }
}
