//
//  FeatureCard.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 23/02/2024.
//

import SwiftUI

struct FeatureCard: View {
    var park: Park
    
    var body: some View {
        park.image?
            .resizable()
            .overlay {
                TextOverlay(park: park)
            }
    }
}

struct TextOverlay: View {
    var park: Park
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                Text(park.country)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    FeatureCard(park: ModelData().features[0])
        .aspectRatio(3/2, contentMode: .fit)
}
