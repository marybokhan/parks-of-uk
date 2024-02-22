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
            if let image = park.image {
                image
                    .resizable()
                    .frame(width: 50, height: 50)
            } else {
                Image("park-placeholder")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
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
