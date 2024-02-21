//
//  ParkDetail.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 19/02/2024.
//

import SwiftUI

struct ParkDetail: View {
    var body: some View {
        ScrollView {
            MapView()
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -120)
                .padding(.bottom, -100)
            
            VStack(alignment: .leading) {
                Text("Broads")
                    .font(.title)
                Text("England")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About")
                    .font(.title3)
                Text("The Norfolk and Suffolk Broads are Britain’s largest protected wetland and are unlike anywhere else. A rich tapestry of landscape, water and wildlife; woven together by history.\nTake to the water to discover our unique waterways, or soak up the history and wildlife on land. Either way, in the words of naturalist Ted Ellis, the Broads truly is a “breathing space for the cure of souls”.")
                    .padding(.bottom, 5)
                Text("Key Activities")
                    .font(.title3)
                Text("Boating, Walking & Cycling, Wildlife watching")
                    .padding(.bottom, 5)
                Text("Website")
                    .font(.title3)
                Text("https://www.visitthebroads.co.uk")
            }
        }
        .padding()
    }
}

#Preview {
    ParkDetail()
}
