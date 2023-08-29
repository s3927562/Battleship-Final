//
//  HowToPlaySheet.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 27/08/2023.
//

import SwiftUI

struct HowToPlaySheet: View {
    var body: some View {
        // NavigationStack for back button
        NavigationStack {
            VStack {
                Text("Helpful Text")
            }
            .toolbar {
                SheetToolbar()
            }
        }
    }
}

struct HowToPlaySheet_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlaySheet()
    }
}
