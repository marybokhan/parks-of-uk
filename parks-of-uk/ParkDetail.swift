//
//  ParkDetail.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 19/02/2024.
//

import SwiftUI

struct ParkDetail: View {
    @Environment(ModelData.self) var modelData
    var park: Park
    
    var body: some View {
        ScrollView {
            MapView(cooordinate: park.locationCoordinate)
                .frame(height: 300)
            
            CircleImage(image: park.image)
                .offset(y: -120)
                .padding(.bottom, -100)
            
            VStack(alignment: .leading) {
                Text(park.name)
                    .font(.title)
                Text(park.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About")
                    .font(.title3)
                Text(park.description)
                    .padding(.bottom, 5)
                Text("Key Activities")
                    .font(.title3)
                Text(park.keyActivities)
                    .padding(.bottom, 5)
                Text("Website")
                    .font(.title3)
                Text(park.website)
            }
            .padding()
        }
    }
}

#Preview {
    let modelData = ModelData()
    return ParkDetail(park: modelData.parks[2])
        .environment(modelData)
}
