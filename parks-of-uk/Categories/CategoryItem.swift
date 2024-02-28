//
//  CategoryItem.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct CategoryItem: View {
    @Environment(\.colorScheme) var colorScheme
    var park: Park
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: park.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Image("park-placeholder").resizable()
            }
            .frame(width: 155, height: 155)
            .cornerRadius(5)
            
            Text(park.name)
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

#Preview {
    CategoryItem(park: ModelData().parks[7])
}
