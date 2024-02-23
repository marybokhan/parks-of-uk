//
//  CategoryHome.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct CategoryHome: View {
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        NavigationSplitView {
            List {
                PageView(pages: modelData.features.map {
                    FeatureCard(park: $0) })
                .listRowInsets(EdgeInsets())
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, parks: modelData.categories[key]!)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
        } detail: {
            Text("Select a Park")
        }
    }
}

#Preview {
    CategoryHome()
        .environment(ModelData())
}
