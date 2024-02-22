//
//  MainView.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct MainView: View {
    @State private var selection: Tab = .countries
    
    enum Tab {
        case countries
        case list
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Countries", systemImage: "star")
                }
                .tag(Tab.countries)
            
            ParkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

#Preview {
    MainView()
        .environment(ModelData())
}
