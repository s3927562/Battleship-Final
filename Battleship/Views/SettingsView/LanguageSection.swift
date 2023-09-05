/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 05/09/2023
 Last modified: 05/09/2023
 Acknowledgement:
 RMIT University, COSC2659 Course, Week 1 - 5 Lecture Slides & Videos
 Introduction to Localization: https://fluffy.es/introduction-to-localization/
 */

import SwiftUI

struct LanguageSection: View {
    @Binding var language: Language
    var body: some View {
        // Languages
        Section {
            //            if (NSLocale.preferredLanguages.count == 1) {
            Picker("Language", selection: $language) {
                ForEach(Language.allCases.sorted { $0.rawValue < $1.rawValue }, id: \.self) {
                    Text($0.textValue)
                }
            }
            Text("Changes will take effect from the next launch")
            //            } else {
            //                Button {
            //                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            //                } label: {
            //                    Text("Open Settings app")
            //                }
            //                Text("Changing the language will close the app")
            //            }
        } header: {
            Text("Language")
        }
        
        .onChange(of: language) { _ in
            // Set display language
            UserDefaults.standard.set([language.code], forKey: "AppleLanguages")
        }
    }
}

struct LanguageSection_Previews: PreviewProvider {
    @AppStorage("language") private static var language: Language = .enUS
    static var previews: some View {
        Form {
            LanguageSection(language: $language)
        }
    }
}
