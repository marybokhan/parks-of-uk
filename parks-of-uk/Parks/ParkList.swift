//
//  ParkList.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct ParkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false
    
    var filteredParks: [Park] {
        modelData.parks.filter { park in
            (!showFavoritesOnly || park.isFavorite)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredParks) { park in
                    NavigationLink {
                        ParkDetail(park: park)
                    } label: {
                        ParkRow(park: park)
                    }
                }
            }
            .animation(.default, value: filteredParks)
            .navigationTitle("National Parks")
        } detail: {
            Text("Select a Park")
        }
    }
}

#Preview {
    ParkList()
        .environment(ModelData())
}
