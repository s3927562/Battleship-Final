//
//  SettingsView.swift
//  Battleship
//
//  Created by Tung Tran Thanh on 26/08/2023.

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
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
                        Button("Reset All Data", role: .destructive) {
                            showAlert = true
                        }
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                        Text("Main Menu")
                    }
                    
                }
            }
            .alert("Reset All Data", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    isReset = true
                }
            }
            .onChange(of: isReset) { _ in
                if isReset {
                    for difficulty in difficulties.keys {
                        let fileName = "\(difficulty.lowercased()).json"
                        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                            let file = dir.appendingPathComponent(fileName)
                            if FileManager.default.fileExists(atPath: file.path) {
                                print ("exist")
                                let data = try! Data(contentsOf: file)
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
