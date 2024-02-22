//
//  CategoryRow.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var parks: [Park]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(parks) { park in
                        NavigationLink {
                            ParkDetail(park: park)
                        } label: {
                            CategoryItem(park: park)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

#Preview {
    let parks = ModelData().parks
    return CategoryRow(categoryName: parks[8].country, parks: Array(parks.prefix(4)))
}
