/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Thanh Tung
 ID: s3927562
 Created  date: 05/09/2023
 Last modified: 05/09/2023
 Acknowledgement: SwiftUI Localization Tutorial for iOS: Getting Started | Kodeco: https://www.kodeco.com/27469286-swiftui-localization-tutorial-for-ios-getting-started
 */

import Foundation

enum Language: String, CaseIterable {
    case enUS
    case viVN
    
    var code: String {
        switch self {
        case .enUS: return "en-US"
        case .viVN: return "vi-VN"
        }
    }
    
    var textValue: String {
        switch self {
        case .enUS: return "English"
        case .viVN: return "Tiếng Việt"
        }
    }
}
