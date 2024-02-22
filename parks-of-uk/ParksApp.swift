//
//  ParksApp.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 19/02/2024.
//

import SwiftUI

@main
struct ParksApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(modelData)
        }
    }
}
