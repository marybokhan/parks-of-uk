//
//  CategoryItem.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct CategoryItem: View {
    var park: Park
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = park.image {
                image
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
            }
            
            Text(park.name)
                .foregroundStyle(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

#Preview {
    CategoryItem(park: ModelData().parks[7])
}
