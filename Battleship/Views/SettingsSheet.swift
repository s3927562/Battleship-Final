//
//  SettingsView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.
//
//  https://blog.logrocket.com/building-forms-swiftui-comprehensive-guide/#converting-components-form
//  https://sarunw.com/posts/swiftui-form-picker-styles/

import SwiftUI

struct SettingsSheet: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("selectedDifficulty") private var selectedDifficulty = "Easy"
    @State private var isReset = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    } header: {
                        Text("Appearance")
                    }
                    
                    Section {
                        Picker("", selection: $selectedDifficulty) {
                            ForEach(Array(difficultyDict).sorted { $0.value.id < $1.value.id }, id: \.self.key) {
                                Text($0.key)
                            }
                        }
                        .pickerStyle(.segmented)
                        Text(difficultyDict[selectedDifficulty]!.description)
                    } header: {
                        Text("Difficulty")
                    }
                    
                    Section {
                        Button("Reset All Data", role: .destructive) {
                            showAlert = true
                        }
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .toolbar {
                SheetToolbar()
            }
            .alert("Reset All Data", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    isReset = true
                }
            } message: {
                Text("This action cannot be undone")
            }
            .onChange(of: isReset) { _ in
                if isReset {
                    for difficulty in difficultyDict.keys {
                        let fileName = "\(difficulty.lowercased()).json"
                        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                            let file = dir.appendingPathComponent(fileName)
                            if FileManager.default.fileExists(atPath: file.path) {
                                do {
                                    try FileManager.default.removeItem(at: file)
                                } catch let error {
                                    print(error)
                                }
                            }
                        }
                        isReset = false
                    }
                }
            }
            
        }
    }
}

struct SettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheet()
    }
}
