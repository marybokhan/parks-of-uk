//
//  ParkRow.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 22/02/2024.
//

import SwiftUI

struct ParkRow: View {
    var park: Park
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: park.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Image("park-placeholder").resizable()
            }
            .frame(width: 50, height: 50)
            
            Text(park.name)
            
            Spacer()
            
            if park.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview {
    let parks = ModelData().parks
    return ParkRow(park: parks[5])
}
