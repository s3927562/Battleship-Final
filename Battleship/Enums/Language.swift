//
//  File.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 05/09/2023.
//

import Foundation

enum Language: String, CaseIterable {
    case en
    case vn
    
    var textValue: String {
        switch self {
        case .en: return "English"
        case .vn: return "Tiếng Việt"
        }
    }
}
